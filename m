Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801578;
	b=AkeIVwIdFfCnPnY5UJYrNxdZrdPCeU/JQz/3pjRKr97o5zQAMTSy8fyP0PtOAyt2jvJ7
	 hl7NM92mZzwbi3KmEP9G9vJ1dgFnmNor+tXpCo9TKpQJN6X5RXms+aHcxnNECE34om9DS
	 gRpCpjEpV7qGuZhw+3jsXpdxEaqiVfFi6TjFrAuDpIG7FuUyPOo66WR+jCAQbqdsFncQj
	 tX9ygzpCRQ4/Ymhpy20EFXN0TjyOrvQo3mJYde6KqgtOkKI4wZDXgYJEw642rwOVQSTHR
	 UD7Jm0/Udb5GBcKBaJcPtvvJ8KKXHO8zDxv7cr9/ZyxZR7TNqfd2/wGRQSY7Y4nVBCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801578;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=idzZSOAti8Nn8PmKa4YUHdyHhnbm+xhVJSm51eKcTeE=;
	b=nphTYuC0YWP1WA7wcal+DnW+xhUVlTOPNJwgLID+Q6Db0E3QI+CD+ec53EEN/uCf6BEs
	 0Irv/OI/oOjAQsZFAvV39yjoq68h+g8qwl40ARqLn8QVAeg97lFgwJLu5V+HMn8iQ/dqE
	 BTBaiXXttx34PG7iJVBeAiQMjAscTfziDg2yQT8ysi8QdWSNHot6yzR7iTKoROIMm5FNT
	 iJiSaELocqLBR3aEVv5YNh22LU50OtT3tw4QDlQfWeYdIMDeROLQpsDXBtVbGKB1z43cQ
	 NQUWhR4b3uoptXKasMRGrPZXury0lWJ2k87CfvYNum3BBWYPedbLybd2oBR44YYDrSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=eitjPjg6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A645606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=eitjPjg6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011CE1F0093A;
	Wed,  4 Nov 2026 14:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793801578;
	bh=idzZSOAti8Nn8PmKa4YUHdyHhnbm+xhVJSm51eKcTeE=;
	h=Subject:To:Cc:From:Date;
	b=eitjPjg6YgclGPr3XYuq81LD8GF+GqDw8AQwQo2nfoV516Mu0boRMxo+c+7XrYJMi
	 xr9r4+5iVhK3Yn9v3rgwiWEYhBstT70yc3UePPwO56QYryX9fSXxs0Rs7Egvtezxk0
	 URned3aCrg+ur+U0ZyJTbiN0LvSdm3+Cr1CYDJog=
Subject: FAILED: patch "[PATCH] rust: bug: update the SAFETY comment for warn_slowpath_fmt()" failed to apply to 6.18-stable tree
To: fujita.tomonori@gmail.com,ojeda@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:12:56 +0100
Message-ID: <2026110456-quartet-gondola-4267@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 5c94956f2bfb87025c1eaded6c51d5841d38d333
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110456-quartet-gondola-4267@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5c94956f2bfb87025c1eaded6c51d5841d38d333 Mon Sep 17 00:00:00 2001
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
Date: Fri, 2 Oct 2026 19:45:50 +0900
Subject: [PATCH] rust: bug: update the SAFETY comment for warn_slowpath_fmt()
 on UML

The SAFETY comment says that it is always safe to call
`warn_slowpath_fmt()` with a valid null-terminated string. This is not
true. The taint argument must also be a valid taint number.
Commit 951d09ca450c ("rust: bug: pass TAINT_WARN to warn_slowpath_fmt()
on UML") fixed a bug where it was not.

List each condition that the call meets: the file name, the taint
number, and the null `fmt`.

Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Link: https://patch.msgid.link/20261002104550.2877930-1-tomo@flapping.org
Cc: stable@vger.kernel.org
Fixes: dff64b072708 ("rust: Add warn_on macro")
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

diff --git a/rust/kernel/bug.rs b/rust/kernel/bug.rs
index 6abed2c055b1..3b40b0bd37b5 100644
--- a/rust/kernel/bug.rs
+++ b/rust/kernel/bug.rs
@@ -88,8 +88,10 @@ macro_rules! warn_flags {
             _ = $flags;
         }
 
-        // SAFETY: It is always safe to call `warn_slowpath_fmt()`
-        // with a valid null-terminated string.
+        // SAFETY:
+        // - The file name is a null-terminated string with `'static` lifetime.
+        // - `TAINT_WARN` is a valid taint number.
+        // - `fmt` can be NULL, and NULL is passed.
         unsafe {
             $crate::bindings::warn_slowpath_fmt(
                 $crate::str::CStrExt::as_char_ptr($crate::c_str!(::core::file!())),

