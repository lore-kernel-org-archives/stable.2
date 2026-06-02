Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0F537C928
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 01:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780450711; cv=none; b=Wn8irMyHkc1nDHZRnQI4K6OWnaD+0MgGIkjXUFXs/vq9/Ry4VWuSTveZuOSL3HMVMSC1fx8WfNDVm5ZCCYiRoQZlnFZi/+zsfzkpojxrGY4tBYRPKufJ5R+eFGkHLqgc+SbRkUb2daBD+x4Xv7q9Hb0Rtl0klOjpn/YxeW7W+vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780450711; c=relaxed/simple;
	bh=QxrzYeHZ9k2TdtXLJ7NosY0R953zUVso6EmSGeoENEE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u2oi+zfoJGhmg1xM1cYXoY07gejJE4FXcQnNdu+2LSgxlkn3gDrfdKB4atMAn04jl3eHJD4XmSIrmFvhwLheEPuqk0kNveo/gOFaVY1vocMHEd30jxL3IVn9kStEraPksKbn7AtunvtF8OEFXzcqdUlLrwA8TtGXzoBx+sAJX4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=dGlHD/3/; arc=none smtp.client-ip=109.224.244.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="dGlHD/3/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1780450706; x=1780709906;
	bh=cRGdVuL25/+8RzBGzRV7c+495EWiR/Aa1Z4J451vdts=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=dGlHD/3/ghgt39AJb2Ixbo7JOiaPweeFmEAwkwquDb4jCwLzWaPvckLeR+H2U+0Uy
	 mNHflpTf5Pg5HvN0AdP1xGz2BmapYjtAFlrHZAJPE+86Ly8O2ERQlbd//sj3RmSDeD
	 LAEAWILtnYnjJMcRq0r2vcWm6SuH0e6YNbJSBchcJZB3bxoWoAp13ACQPm08jNMqzL
	 O51seE2IvBH5pKyH2OUxEe3jnF7f56TOwWdj8WPDRENShwEv0verZkY2OUF1Yi1izT
	 dqJOY8ZH6rtAn8nw8hYwPO01wjZpgSDKZJWC7OfRiAVERDGSCzCqpktZJseEK+iFKy
	 BsOblr/Rbzh7A==
Date: Tue, 02 Jun 2026 17:28:05 +0000
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, =?utf-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Justin Suess <utilityemal77@gmail.com>, Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] selftests/landlock: test SCOPE_SIGNAL on the SIGIO/fowner pgid path
Message-ID: <20260602172741.18760-3-hexlabsecurity@proton.me>
In-Reply-To: <20260602172741.18760-1-hexlabsecurity@proton.me>
References: <7rvmLIHR1Zh8RDF1IY1-SYRHzErgw9gPHq0k98RLYVsmHqAejjxcuJi8V3QaSbW-SnNvY5tfM2Xn_S1dEajKV_f7iyitoPwJgOSTZQ0nytc=@proton.me> <20260531.irah0eiM3Chi@digikod.net> <20260602172741.18760-1-hexlabsecurity@proton.me>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 335be816ca89f676268cd269abca1c33a7fd1f39
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add a regression test for the LANDLOCK_SCOPE_SIGNAL bypass on the
asynchronous SIGIO delivery path.  A sandboxed process that owns a file
via fcntl(F_SETOWN, -pgrp) while sitting at the head of its process
group's PID hlist (the default position after fork()) used to have its
Landlock domain recording skipped, letting the SIGIO fan-out reach
non-sandboxed members of the process group.

The test creates a dedicated process group, sandboxes the (hlist-head)
child with LANDLOCK_SCOPE_SIGNAL, arms F_SETSIG(SIGURG) / F_SETOWN(-pgrp)
/ O_ASYNC on a pipe and triggers the fan-out.  The in-domain child must
receive the signal (proving the trigger fired); the non-sandboxed parent,
which is outside the child's domain, must not.  Without the fix the parent
is signaled and the test fails.

Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
 .../selftests/landlock/scoped_signal_test.c   | 97 +++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/tools/testing/selftests/landlock/scoped_signal_test.c b/tools/=
testing/selftests/landlock/scoped_signal_test.c
index d8bf33417619..62d86a115775 100644
--- a/tools/testing/selftests/landlock/scoped_signal_test.c
+++ b/tools/testing/selftests/landlock/scoped_signal_test.c
@@ -559,4 +559,101 @@ TEST_F(fown, sigurg_socket)
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
t
+ * and the signal fanned out to every group member, including non-sandboxe=
d
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
+=09 * Isolates the test in its own process group so the SIGIO fan-out
+=09 * stays bounded to this parent and the child forked below.
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
 TEST_HARNESS_MAIN
--=20
2.43.0


