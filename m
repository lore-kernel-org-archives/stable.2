Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801569;
	b=J6qCvn3LEd+pMLlf8QeD/uZxzhuCeTk0yMWJd8vuh+BOOY+aNl3pxNcPgsYt8W8RQU2O
	 C6cJ4lPTt5OtG0dM6FGXQAHg3QWSK2W83P6yEEj1yHd8tR+LmCH88hEIyzhLw070WGuHu
	 fu8khJdmZ+qyHfqmusWa/GvcYSLK/9tV1EasQa+wk5Tlg/Bo7/+XkarozheZoqfGYRcUQ
	 1Hd3mhQi/dL0cjXDAWozbyFIKOSf2XgZ6UiWONdBOrn65BeFmOooTwMQEi1EsWbrk03fV
	 t7NySHI9Fp7Jdtx1THNcFpgKpfHg6WKgp3mb3LioncGxWr7kxcjXHzmPKcfD55EnShw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801569;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=jtm/9zPdFyj68CuHfrjmnEMaK/H5sEE0hoFMnrN2JLo=;
	b=enAapJLg5YAZrJDEYFh3sJCzRw20XaEuJPERJb9h4eXZCjYRZj/MwuIKQRZgg0I7Y2Tc
	 W3QuLMzB2rMF1Z4rX+rNxgpPaiw3r7Nzj2DquMBdqw796buph0z4ZVZYjRKXWP7vn18df
	 Mm5fU5mgluwQvMyi53Nj1rQGgH4BXJ2RKRzKjXWneaBumOHxBw/9ItuAnsiFj25Y9Yh2+
	 ocfWyDcqDJgXJV69jWSgFX/4oX/7JBLsN6s5HxGvsIfk225LKt7BaEcapZgiwSZomrNiQ
	 5f4ehN10eDfkDWxp0vL6sL6N8c3Me1dtWCWtpndjpg2+szTM8Sg7pCpNUpNBB+pcRzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=i2pllzWP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA95C606D806
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=i2pllzWP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3407C1F0093A;
	Wed,  4 Nov 2026 14:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793801568;
	bh=jtm/9zPdFyj68CuHfrjmnEMaK/H5sEE0hoFMnrN2JLo=;
	h=Subject:To:Cc:From:Date;
	b=i2pllzWPZIypfk+gKtLKHiHgS+XIN4FOZRJgI7lz5a56Xw2WUV4vMCoWQdJA3YTPF
	 97BxU0am/tUpvWf6GMJqzHZqyayynn4bsckmSX5r9A+rNR/8W4mrKehEJDZ6s1OOar
	 VcrSeaW910TkAnu0w+B+90pmyVinqTiFpB7CnxjE=
Subject: FAILED: patch "[PATCH] rust: bug: pass TAINT_WARN to warn_slowpath_fmt() on UML" failed to apply to 6.18-stable tree
To: fujita.tomonori@gmail.com,ojeda@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:12:47 +0100
Message-ID: <2026110447-anything-wildcard-f4e0@gregkh>
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
git cherry-pick -x 951d09ca450ca76a695016ea76c3fa653bd20439
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110447-anything-wildcard-f4e0@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 951d09ca450ca76a695016ea76c3fa653bd20439 Mon Sep 17 00:00:00 2001
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
Date: Thu, 1 Oct 2026 21:31:03 +0900
Subject: [PATCH] rust: bug: pass TAINT_WARN to warn_slowpath_fmt() on UML

On UML, `warn_flags!` calls `warn_slowpath_fmt()` directly. Its third
argument is a taint number, but `warn_on!` passes its bug flags there.

As a result, `add_taint()` gets 2304 instead of 9 (`TAINT_WARN`). The
warning is not recorded: `/proc/sys/kernel/tainted` stays 0 after
`warn_on!` fires, where it should be 512. It also causes an
out-of-bounds write in `add_taint()`.

Pass `TAINT_WARN` directly, as C does on UML.

Cc: stable@vger.kernel.org
Fixes: dff64b072708 ("rust: Add warn_on macro")
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Link: https://patch.msgid.link/20261001123103.2198104-1-tomo@flapping.org
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

diff --git a/rust/kernel/bug.rs b/rust/kernel/bug.rs
index 3566f0234ca4..af8eba4563de 100644
--- a/rust/kernel/bug.rs
+++ b/rust/kernel/bug.rs
@@ -85,6 +85,7 @@ macro_rules! warn_flags {
     ($file:expr, $flags:expr) => {
         if false {
             _ = $file;
+            _ = $flags;
         }
 
         // SAFETY: It is always safe to call `warn_slowpath_fmt()`
@@ -93,7 +94,7 @@ macro_rules! warn_flags {
             $crate::bindings::warn_slowpath_fmt(
                 $crate::str::CStrExt::as_char_ptr($crate::c_str!(::core::file!())),
                 line!() as $crate::ffi::c_int,
-                $flags as $crate::ffi::c_uint,
+                $crate::bindings::TAINT_WARN,
                 ::core::ptr::null(),
             );
         }

