Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794372888;
	b=nCAedGwLJQOFE5mTs2XQ3hK14KLwxrdmJxtqP0lleKEgjZt2K3GSZl/1xOAO86IPjweD
	 03PLVaIP4qyvfGVOF8vasrvN/vREnhIkc0eORYrDtvn8jszYORm6SsyIFM7iDkdh/LGtI
	 cfN63rLhDvNZQrDT4MrwWk3ZQ+y1kvJu3wV/v7g8cltNlAWt5HMkVLcBGg7Tyxo4bK6eV
	 X1Vdbh3PPmc3E+R8JBXImpy+2Sy3CBSqMvmObvOtG3CsxQoAJGWABLeN1k8fjRLIv7m5E
	 xhHZYliLpYR/x/vWb5CmaZraU/B/PHzHv6uVwP7mQgACpwMqeZRlvwbt3w6gokeFUKA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794372888;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=BWQmGmJya3rTCVRcVfS+YlSp5iNMVlB54NT+v8IKoXw=;
	b=JRBXXpL7ss5ke74ivnWErVctGjjm2w10vfb8Zx9EyI6iMOtHONYWeGD7pYq4JtNaV7HH
	 5NEERWrqJe1lTWxnjUu1xQhzvZRvsEbBwFJdBlMSQF8V3Fm6shYuKi+FYQX/030g1pGJH
	 Xl2LrC9oQFII+Lgxn5Lct/1iQUunoODOU9yqLPTfKeebTKkojGAm6+mWthHgTnUKZHwOf
	 VRKzBU9pFx17k4mLrxhK0d0YHkWSFal26QuqnpMjmd0ILfiTQPRD47Fm7oSJnkXoGou+Y
	 VzViwlIwdZJzz4g2hYPxd18nj1epz0eeqBuroTWsIhQIKw/U+vRAzPZz0FWMxLT7LSA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bHcI7e14;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB46606A332;
	Wed, 11 Nov 2026 04:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bHcI7e14
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794372888;
	b=T5m2ASId52Jz779rqMmY18S18xwftEzCk4HEZvMimOnNM9x85ouy/TnRV61SfHji82/0
	 LYA/nCvQ/G7ax/SN2BTzT88DxMHpo/Qx8rbyISQEdWN2v3tMvg5eqCBSdaB9ukfVBnXxX
	 GVNgjJHXeJhaVlMecgxsE2On+Qm3QI+DNJSaujXo2riTyXJOZLv9v5O5XOAJT8czCU38k
	 V1xoRnQyn7I/zbx+CqUDNNYWW2D3kT7zyEqwtR+67YcRCYBvyefbPoLCWvlGwSDVNwPAb
	 wkljlu52aaTCtpn++3EV8gLkXl5h1p7++S3iNXxnNjv2D+41fFVm42IhjdtFDEIU1HA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794372888;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=BWQmGmJya3rTCVRcVfS+YlSp5iNMVlB54NT+v8IKoXw=;
	b=XDEGOhsEa/UEXV/0S7QwvIz3nhlrd5toGWqP1hwJFgrYD9w6tyZRpZQLwtocx2WUtbGN
	 1tU7PBxTtbyBycmws2rD+z1xzHlepSwwarsI0OCcRbaIhgEsIEWMN0bgHXqsuhckIyS7F
	 lmnlYou0gZ0IoDJSwJieVsGcXw10fzE1uf0FmqSpkxDNwsYRZirEinxIwLP/1lrco8gzs
	 QqvfQdxTDDt5QE6dysMVkEFmULv/vMECkkNOIMGXLwcBEQrJ4507N33RT9HAKXifp7gJg
	 vMbqnpyj3WptrzU+rmXcUx4EdEvPagQ9idMjsMFTkgWqGO3gx5VImGzB7FXYqXHGP9w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 731DA1F00A00;
	Wed, 11 Nov 2026 04:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794372888;
	bh=BWQmGmJya3rTCVRcVfS+YlSp5iNMVlB54NT+v8IKoXw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=bHcI7e14vKFMrX4fCmUdpKU9G+SII5oQoHgBbGLnAEfLtb+lQpo500XI3yXdswEK/
	 mMlOxcfA3f/KDTRYrANKBS/KXfSmjKobnK2yjT+E7bK6aI0U2nkAIqOl6kPoJn6hpZ
	 YlXUl8aC3bCfGdtr9LUaOAwgQ5ZRTm/hrNtLx13ZcL5GjCSWad6v+iyPD89vBo3oGv
	 jAbP7B3UraMo/BJLBkv80Ppd3lHtvubqgcVyMXea+BR5gUKAZeJx97dKXMf1gGAXD6
	 QrU7GNnKa43znHS9p0RfUrOa+kN7S9l833VKFUkLsaGMwKUClpU41f3R0D3y/daF2X
	 OnhbOQIJZ7Qjg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D946D48DAB;
	Wed, 11 Nov 2026 04:54:46 +0000 (UTC)
From: Daejun Park via B4 Relay <devnull+daejun7.park.samsung.com@kernel.org>
Date: Wed, 11 Nov 2026 13:54:46 +0900
Subject: [PATCH 1/2] landlock: Fix landlock_restrict_self() failure on long
 executable paths
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
Message-Id: <20261111-landlock-long-exe-v1-1-588cfd174a10@samsung.com>
References: <20261111-landlock-long-exe-v1-0-588cfd174a10@samsung.com>
In-Reply-To: <20261111-landlock-long-exe-v1-0-588cfd174a10@samsung.com>
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Dwi Siswanto <me@dw1.io>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>, 
 linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Daejun Park <daejun7.park@samsung.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794372885; l=3932;
 i=daejun7.park@samsung.com; s=20261006; h=from:subject:message-id;
 bh=f/18UpIHEi230vx5Ck3a8ZJ9SX6Z8YLTouikgG7pJjU=;
 b=lZtEj/fYt7MzgKNh5JAsBrOfa5F+2IWnMtSyCemCE/EOVEywBi5MDExD5cmbB8rPoEY24HC6S
 KbJ5auThT4eDTmbGYU3nETY59/zIMDOq2+DXamc9M8qY57RYXfx7l5D
X-Developer-Key: i=daejun7.park@samsung.com; a=ed25519;
 pk=4yUfDqGRZTIj0Ik43z1GoMZRWCNm/rgX6uJuM9dtNIg=
X-Endpoint-Received: by B4 Relay for daejun7.park@samsung.com/20261006 with
 auth_id=1122
X-Original-From: Daejun Park <daejun7.park@samsung.com>
Reply-To: daejun7.park@samsung.com
Content-Transfer-Encoding: 7bit

From: Daejun Park <daejun7.park@samsung.com>

get_current_exe() treats a d_path() error on the current executable as
a bug. But an absolute path is not bounded by PATH_MAX, and d_path()
returns -ENAMETOOLONG when the path does not fit in the
LANDLOCK_PATH_MAX_SIZE buffer.

An unprivileged task with such an executable triggers the
WARN_ON_ONCE(), and its landlock_restrict_self() call fails with
-ENAMETOOLONG.

The path is not used for enforcement. Record "<too_long>" instead, as
audit_log_d_path() does, and create the domain.

Reported-by: Dwi Siswanto <me@dw1.io>
Closes: https://lore.kernel.org/r/20261102022018.73143-1-me@dw1.io
Suggested-by: Dwi Siswanto <me@dw1.io>
Fixes: 1d636984e088 ("landlock: Add AUDIT_LANDLOCK_DOMAIN and log domain status")
Cc: stable@vger.kernel.org
Signed-off-by: Daejun Park <daejun7.park@samsung.com>
---
 Documentation/admin-guide/LSM/landlock.rst |  3 ++-
 security/landlock/domain.c                 | 15 +++++++++++----
 security/landlock/domain.h                 |  3 ++-
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/LSM/landlock.rst b/Documentation/admin-guide/LSM/landlock.rst
index 718e0d23ffb5..983223ce6818 100644
--- a/Documentation/admin-guide/LSM/landlock.rst
+++ b/Documentation/admin-guide/LSM/landlock.rst
@@ -104,7 +104,8 @@ AUDIT_LANDLOCK_DOMAIN
     - the enforcement ``mode``
     - the domain creator's ``pid``
     - the domain creator's ``uid``
-    - the domain creator's executable path (``exe``)
+    - the domain creator's executable path (``exe``), or ``"<too_long>"`` if
+      this path does not fit in the kernel buffer
     - the domain creator's command line (``comm``)
 
     Example::
diff --git a/security/landlock/domain.c b/security/landlock/domain.c
index 4c0b1f0e1db5..4c9858c11b3d 100644
--- a/security/landlock/domain.c
+++ b/security/landlock/domain.c
@@ -492,7 +492,8 @@ landlock_merge_ruleset(struct landlock_domain *const parent,
  * get_current_exe - Get the current's executable path, if any
  *
  * @exe_str: Returned pointer to a path string with a lifetime tied to the
- *           returned buffer, if any.
+ *           returned buffer, if any. It is "<too_long>" if the path does
+ *           not fit in this buffer.
  * @exe_size: Returned size of @exe_str (including the trailing null
  *            character), if any.
  *
@@ -502,6 +503,8 @@ landlock_merge_ruleset(struct landlock_domain *const parent,
 static const void *get_current_exe(const char **const exe_str,
 				   size_t *const exe_size)
 {
+	/* Cf. audit_log_d_path() */
+	static const char too_long_path[] = "<too_long>";
 	const size_t buffer_size = LANDLOCK_PATH_MAX_SIZE;
 	struct mm_struct *mm = current->mm;
 	struct file *file __free(fput) = NULL;
@@ -521,9 +524,13 @@ static const void *get_current_exe(const char **const exe_str,
 		return ERR_PTR(-ENOMEM);
 
 	exe = d_path(&file->f_path, buffer, buffer_size);
-	if (WARN_ON_ONCE(IS_ERR(exe)))
-		/* Should never happen according to LANDLOCK_PATH_MAX_SIZE. */
-		return ERR_CAST(exe);
+	if (IS_ERR(exe)) {
+		/* The path does not fit: it is not bounded by PATH_MAX. */
+		memcpy(buffer, too_long_path, sizeof(too_long_path));
+		*exe_size = sizeof(too_long_path);
+		*exe_str = buffer;
+		return no_free_ptr(buffer);
+	}
 
 	size = buffer + buffer_size - exe;
 	if (WARN_ON_ONCE(size <= 0))
diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index 935e18b12b3c..d087882fd428 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -72,7 +72,8 @@ struct landlock_details {
 	/**
 	 * @exe_path: Executable path of the task that initially restricted
 	 * itself, at creation time.  Always NULL terminated, and never greater
-	 * than LANDLOCK_PATH_MAX_SIZE.
+	 * than LANDLOCK_PATH_MAX_SIZE. It is "<too_long>" if the path does not
+	 * fit.
 	 */
 	char exe_path[];
 };

-- 
2.43.0


