Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE5F2C187
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 23:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780615040; cv=none; b=d+5efzhbXfjTCEoXiI5ITtu/f3dFklHa6tJFTAVVJFy+YvxLfM9qrRyBRr2BkZLCjLZhQR4UZicK8Iil3HQGQUucR56SisDyGh3RBX2vwoDwsISVuIBTt8fXsGVsMGgXn2LGm9nADs/BykdU6yMDX0ayi++uWYs7JFsY1UyrRw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780615040; c=relaxed/simple;
	bh=9Y9Q3Oq/g2HsbSWx5NVzvzfWZLMDBobgubpbg/JDEYs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dOpRv44qf9fuH9bE65BN9FcNXpcYmx0aGEZsddzpdkWeb4ctyXUPL8fFHP9wLcOHvwf2ZbTFIMUeMjnD/9omIhLFEod/6tKaRCJJN3GZWAGxc9YQMOv1/5ws0/8O8p8VoHyhLUkdMlbV36JqEjFqoSPOuKFFEcBLWbFdqscLZ64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=IXImmDNk; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="IXImmDNk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1780615030; x=1780874230;
	bh=LXhUaratdOjfuU2bCMULOdZjqvbpqRpbGJZQuxWj6C0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=IXImmDNkVEwpwxQS0+ErAYFnisgPyEz6hXK5p1nfNAqQHQe2Fm83KgewFIS862o8E
	 geF2kU5zU/GtpBhtWJYAEIj/hM1P/WnSA6dXLoerjKyg1czZwPfQnsirxjIXvoUB4L
	 jOjfhus8DdU2vI/DQz3qBbqr7lUd3IXl1Pc4B+DyU00X0811tg9OlXMcQoXdg9Axr1
	 mv9m8V1/V/NuVLX8nOIfij2R+N/DF3LDzta8ayCcHcf4ZKw+t2Lj6L/ovXfsVWAN0f
	 dOl8bUVkYmtK1F0gpft6KuhhllyCwvhZRP97i3jvfAgahyEFKS0kTMHuXYNyQXm3aW
	 sX05uWMKg60Pg==
Date: Thu, 04 Jun 2026 23:17:05 +0000
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, =?utf-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Justin Suess <utilityemal77@gmail.com>, Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] selftests/landlock: test SCOPE_SIGNAL on the SIGIO/fowner pgid path
Message-ID: <43370e89f7a896a583bf33d1cd171d02630e61bf.1780614610.git.hexlabsecurity@proton.me>
In-Reply-To: <cover.1780614610.git.hexlabsecurity@proton.me>
References: <cover.1780614610.git.hexlabsecurity@proton.me>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 11b9b891da285b59e3bd5d7a4ca76dcedfdc361b
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add regression tests for the LANDLOCK_SCOPE_SIGNAL handling of the
asynchronous SIGIO delivery path (fcntl(F_SETOWN)) with a process-group
owner.

sigio_to_pgid_members covers the bypass: a sandboxed process at the head
of its process group's PID hlist (the default after fork()) arms
F_SETOWN(-pgrp) + O_ASYNC and triggers the fan-out; the in-domain owner
must be signaled (proving the trigger fired) while the non-sandboxed
member of the group, outside the domain, must not.

sigio_to_pgid_self covers the same-process guarantee: the owner is
registered from a sandboxed non-leader thread, whose domain differs from
the thread-group leader the kernel signals for a process-group owner.
That leader belongs to the owner's own process and must still be signaled.

Without the fix the first test sees the out-of-domain member signaled and
the second sees the owner's own leader denied.

Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
 .../selftests/landlock/scoped_signal_test.c   | 183 ++++++++++++++++++
 1 file changed, 183 insertions(+)

diff --git a/tools/testing/selftests/landlock/scoped_signal_test.c b/tools/=
testing/selftests/landlock/scoped_signal_test.c
index d8bf33417619..4359e0262dcf 100644
--- a/tools/testing/selftests/landlock/scoped_signal_test.c
+++ b/tools/testing/selftests/landlock/scoped_signal_test.c
@@ -559,4 +559,187 @@ TEST_F(fown, sigurg_socket)
 =09=09_metadata->exit_code =3D KSFT_FAIL;
 }
=20
+/*
+ * Checks that LANDLOCK_SCOPE_SIGNAL is enforced on the asynchronous SIGIO
+ * delivery path (fcntl(F_SETOWN)) when the file owner is a process group.
+ *
+ * A sandboxed process sitting at the head of its process group's PID hlis=
t
+ * (the default position right after fork()) used to escape the
+ * fcntl(F_SETOWN, -pgrp) domain recording: pid_task(pgrp, PIDTYPE_PGID)
+ * resolved to the process itself, so the same-thread-group exemption skip=
ped
+ * recording its Landlock domain.  At SIGIO time that domain was then unse=
t and
+ * the signal fanned out to every group member, including non-sandboxed
+ * processes outside the domain.
+ */
+TEST(sigio_to_pgid_members)
+{
+=09int trigger[2], sync_child[2];
+=09char buf;
+=09pid_t child;
+=09int status, i;
+
+=09drop_caps(_metadata);
+
+=09/*
+=09 * Isolates the test in its own process group so the SIGIO fan-out stay=
s
+=09 * bounded to this parent and the child forked below.
+=09 */
+=09ASSERT_EQ(0, setpgid(0, 0));
+
+=09/* The non-sandboxed parent is the protected (out-of-domain) target. */
+=09ASSERT_EQ(0, setup_signal_handler(SIGURG));
+=09signal_received =3D 0;
+
+=09ASSERT_EQ(0, pipe2(trigger, O_CLOEXEC));
+=09ASSERT_EQ(0, pipe2(sync_child, O_CLOEXEC));
+
+=09child =3D fork();
+=09ASSERT_LE(0, child);
+=09if (child =3D=3D 0) {
+=09=09/*
+=09=09 * The child inherits the parent's new process group and, just
+=09=09 * attached with hlist_add_head_rcu(), is now the head of the
+=09=09 * pgid hlist: this is the case that used to skip the recording.
+=09=09 */
+=09=09EXPECT_EQ(0, close(sync_child[0]));
+
+=09=09/* In-domain positive control: the child must be signaled. */
+=09=09ASSERT_EQ(0, setup_signal_handler(SIGURG));
+=09=09signal_received =3D 0;
+
+=09=09create_scoped_domain(_metadata, LANDLOCK_SCOPE_SIGNAL);
+
+=09=09/* Owns the SIGIO source for the whole process group. */
+=09=09ASSERT_EQ(0, fcntl(trigger[0], F_SETSIG, SIGURG));
+=09=09ASSERT_EQ(0, fcntl(trigger[0], F_SETOWN, -getpgrp()));
+=09=09ASSERT_EQ(0, fcntl(trigger[0], F_SETFL, O_ASYNC));
+
+=09=09/* Fans SIGURG out to every member of the process group. */
+=09=09ASSERT_EQ(1, write(trigger[1], ".", 1));
+
+=09=09/*
+=09=09 * The sandboxed child is in its own domain and must always be
+=09=09 * signaled: this proves the SIGIO actually fired.
+=09=09 */
+=09=09for (i =3D 0; i < 1000 && !signal_received; i++)
+=09=09=09usleep(1000);
+=09=09EXPECT_EQ(1, signal_received);
+
+=09=09ASSERT_EQ(1, write(sync_child[1], ".", 1));
+=09=09EXPECT_EQ(0, close(sync_child[1]));
+
+=09=09_exit(_metadata->exit_code);
+=09=09return;
+=09}
+=09EXPECT_EQ(0, close(sync_child[1]));
+=09EXPECT_EQ(0, close(trigger[0]));
+=09EXPECT_EQ(0, close(trigger[1]));
+
+=09/* Waits for the child to generate the SIGIO. */
+=09ASSERT_EQ(1, read(sync_child[0], &buf, 1));
+=09EXPECT_EQ(0, close(sync_child[0]));
+
+=09/* Lets a delivered-but-pending signal run our handler, if any. */
+=09for (i =3D 0; i < 100 && !signal_received; i++)
+=09=09usleep(1000);
+
+=09/*
+=09 * SCOPE_SIGNAL must block the fan-out to this non-sandboxed parent,
+=09 * which is outside the child's Landlock domain.  Before the fix the
+=09 * parent was signaled here.
+=09 */
+=09EXPECT_EQ(0, signal_received);
+
+=09ASSERT_EQ(child, waitpid(child, &status, 0));
+=09if (WIFSIGNALED(status) || !WIFEXITED(status) ||
+=09    WEXITSTATUS(status) !=3D EXIT_SUCCESS)
+=09=09_metadata->exit_code =3D KSFT_FAIL;
+}
+
+static void *thread_setown_scoped(void *arg)
+{
+=09const int fd =3D *(int *)arg;
+=09int ruleset_fd;
+=09const struct landlock_ruleset_attr ruleset_attr =3D {
+=09=09.scoped =3D LANDLOCK_SCOPE_SIGNAL,
+=09};
+
+=09/* Sandboxes only this non-leader thread (no thread syncing). */
+=09ruleset_fd =3D
+=09=09landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+=09if (ruleset_fd < 0)
+=09=09return (void *)THREAD_ERROR;
+=09if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0) ||
+=09    landlock_restrict_self(ruleset_fd, 0)) {
+=09=09close(ruleset_fd);
+=09=09return (void *)THREAD_ERROR;
+=09}
+=09close(ruleset_fd);
+
+=09/* Makes this process group own the SIGIO source. */
+=09if (fcntl(fd, F_SETSIG, SIGURG) || fcntl(fd, F_SETOWN, -getpgrp()) ||
+=09    fcntl(fd, F_SETFL, O_ASYNC))
+=09=09return (void *)THREAD_ERROR;
+
+=09return (void *)THREAD_SUCCESS;
+}
+
+/*
+ * Checks that the SIGIO fan-out is still delivered to the file owner's ow=
n
+ * process when fcntl(F_SETOWN, -pgrp) was issued from a sandboxed non-lea=
der
+ * thread.
+ *
+ * The Landlock domain is recorded for a process-group owner (so out-of-do=
main
+ * members stay blocked, see sigio_to_pgid_members), but the kernel signal=
s a
+ * process group through its members' thread-group leaders.  Here the lead=
er is
+ * not sandboxed and thus has a different domain than the registering thre=
ad, so
+ * the registration-time check cannot tell that it belongs to the owner's =
own
+ * process.  hook_file_send_sigiotask() must recognize it through the reco=
rded
+ * thread group and allow the delivery, matching the same-process guarante=
e of
+ * commit 18eb75f3af40.  Without that exemption the leader is wrongly deni=
ed and
+ * never signaled.
+ */
+TEST(sigio_to_pgid_self)
+{
+=09int trigger[2];
+=09pthread_t thread;
+=09enum thread_return ret =3D THREAD_INVALID;
+=09int i;
+
+=09drop_caps(_metadata);
+
+=09/* Bounds the SIGIO fan-out to this process. */
+=09ASSERT_EQ(0, setpgid(0, 0));
+
+=09/* The non-sandboxed thread-group leader is the SIGIO target. */
+=09ASSERT_EQ(0, setup_signal_handler(SIGURG));
+=09signal_received =3D 0;
+
+=09ASSERT_EQ(0, pipe2(trigger, O_CLOEXEC));
+
+=09/*
+=09 * Registers the process-group fowner from a sibling thread that
+=09 * sandboxes only itself, so its domain differs from the leader's.
+=09 */
+=09ASSERT_EQ(0, pthread_create(&thread, NULL, thread_setown_scoped,
+=09=09=09=09    &trigger[0]));
+=09ASSERT_EQ(0, pthread_join(thread, (void **)&ret));
+=09ASSERT_EQ(THREAD_SUCCESS, ret);
+
+=09/* Fans SIGURG out to the process group. */
+=09ASSERT_EQ(1, write(trigger[1], ".", 1));
+
+=09for (i =3D 0; i < 1000 && !signal_received; i++)
+=09=09usleep(1000);
+
+=09/*
+=09 * Same-process delivery must always be allowed, even though the owner
+=09 * was registered from a sandboxed sibling thread.
+=09 */
+=09EXPECT_EQ(1, signal_received);
+
+=09EXPECT_EQ(0, close(trigger[0]));
+=09EXPECT_EQ(0, close(trigger[1]));
+}
+
 TEST_HARNESS_MAIN
--=20
2.43.0


