Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793048045;
	b=m8Q7+7MqKnkTvn5HJ9LO4ZEx1+G2MT8ewFfut9T0XuUU8Ud9PneL/g6v9Q3cYTcPd8rk
	 aVroi5N7bhxwY23LzSsdI9gZO5kR2dSHm4WcmBpBmTgsohCEAfmS2zyAmQm7M+HzlFdsl
	 R1QDLUY4D0RQWHlpjysC7Rg+2IXQvxJZouNy8R8gyUUo2c58CD9NjyXQqZK/ZhxdmPzv2
	 5kyqWp8cr6QMuj5vUbA3YSSoGDwHpxh9RhwUtBndSfg3PYg5Wxd4mh1v/Wssi+um5sNo1
	 hS6JcbunxYDMXQuvsHrWOzE7sv5c5aao4w5foat592dFYVKJ7Bgzbt6F6aIGte/oQDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793048045;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Y+asd5FcmQ3i2iF1cd+nZYxacxJNYDOSQpqYG634Y2c=;
	b=Y1Zl2t1ed5W+pay3KrWGuLyyg+boQgHjSbHwH1ndZKuYEloB5hVM0ayUz1/XDItfRy+g
	 wFgP/QdkqLetSSfk8uHvVeOLRfsiifFrSWhR5wu6TrJdCYBRfms2pUp97MYWJF3I+Ecna
	 C4lekZhUV9UfPIW/f45pHdfb9LIlLfMnmOW3hr8VxazPdPias/Lqpx/SuMPsnkIi4LkwO
	 uR9rnwFZ7B1wWfii5yYjuXCJ7C1/MtnV2K5y6mjVWX4EkGskmYopm+zSBAksfVe0a9ZZx
	 +AO8/QZqFFSkWCFzubDBirGqWkP3beBxihEv7OKvIclArLd7+iGtq+JNMpiJ7bhGyIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V8N8ippB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7C7606A326;
	Mon, 26 Oct 2026 20:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V8N8ippB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 276721F01825;
	Mon, 26 Oct 2026 20:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793048044;
	bh=Y+asd5FcmQ3i2iF1cd+nZYxacxJNYDOSQpqYG634Y2c=;
	h=From:Subject:Date:To:Cc;
	b=V8N8ippBjZTWjNgvaG+rtSMn0Ugh5vnzsVMSrhfrv/o4IyClHiF5RDGfEWdl05RDS
	 r0anx58IJMeF1VqfmqbhPjY4ET/u3q1Pct2Ir8q3rIZXWsZb74FtTkHsKkq08h7Leg
	 SONRcbgmD10dv1Xw90+GUlUQWH5R96qbp4kk565Ehq0tlAbPwgLOlso9Fg2AXV65/0
	 NsY2ztkve0xA75edvwb/8H4D8Uzzwqjn8tPWVcM51YS5Ea82ZSL5wyOIy86BKD6YIA
	 9reMhiKJ2o8eq2WYNSZw6Y7BF8hVgyB5VtMm3HzEkbTZhZ8BdGbk9sWNtl0vQRO6Bh
	 JPNyqWU592fcQ==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/2] userns: keep the exec securebits
Date: Mon, 26 Oct 2026 21:53:28 +0100
Message-Id: <20261026-work-securebits-userns-v1-0-b35473fa1a34@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/0XMMQ7CMAwF0KtUnnGUdGiBqyCGJHWpQUqR3QBS1
 buT0IHBw7f+fysoCZPCuVlB6MXKcyrBHRqIk083Qh5Khta2nSuH71keqBSzUOBFMRcgKXa2t8E
 d/SkOHsr4KTTy5wdfrnvWHO4Ul6rVRvBKGMSnONVXdc3fNbtragu27Qtum2LcqAAAAA==
X-Change-ID: 20261026-work-securebits-userns-6070b18a9cda
To: linux-fsdevel@vger.kernel.org
Cc: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 Serge Hallyn <serge@hallyn.com>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, Jann Horn <jannh@google.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1917; i=brauner@kernel.org;
 h=from:subject:message-id; bh=iujI9aAJYOrnMNbrp/gBJRYkBHmRYoPzBhbDlZk61JU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTd3/u4PCjlu9GzqZffpKffDVyt+GEhg0D2ggT+SunZz
 QILv8/P6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIwWKGfyqdxvddnLp4zgWk
 x+i43T1SUawhI9v7YobcfqPCfa3M7gz//bvOlohpXH557OWrEjt7Le4zDnc0UpcqybN2Zciu7V3
 MCQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The exec securebits are meant to be set and locked by a service manager
so that nothing below it can turn them off again. But creating a user
namespace resets all securebits, locks included. So anyone who may
create a user namespace can shed them with a single
unshare(CLONE_NEWUSER), and joining one with setns() does the same.
That's pretty much everyone.

systemd gains a SecureBits= setting for the service manager itself. It
sets and locks the exec bits for everything it starts, so interpreters
that support AT_EXECVE_CHECK enforce the system's execution policy for
their scripts. With the reset "unshare -U python3 /tmp/x.py" gets
around all of that.

The other securebits are about how capabilities are computed and
resetting them in a new user namespace is fine. The exec bits grant
nothing. They're restrictions a task placed on itself, like
no_new_privs, which a user namespace doesn't drop either. So keep them
and their locks and keep resetting the rest.

I also keep the exec bits that aren't locked. fork() and execve()
preserve them and the task can clear them itself anyway, so dropping
them on unshare() would just be inconsistent.

The new selftests fail on mainline and pass with the fix. I think this
wants to go to stable, otherwise the locks don't mean much on any kernel
that has these bits.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Christian Brauner (2):
      userns: don't drop the exec securebits
      selftests/exec: check that user namespaces keep the exec securebits

 Documentation/userspace-api/check_exec.rst |  4 ++
 kernel/user_namespace.c                    |  5 +-
 tools/testing/selftests/exec/check-exec.c  | 83 ++++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+), 1 deletion(-)
---
base-commit: 21a7f44fd0765fcc5194130b28767786eba1d1e7
change-id: 20261026-work-securebits-userns-6070b18a9cda

