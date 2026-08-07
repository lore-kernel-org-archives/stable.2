Received: from flow-b7-smtp.messagingengine.com (flow-b7-smtp.messagingengine.com [202.12.124.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F18838F945;
	Fri,  7 Aug 2026 11:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786101884; cv=none; b=kLgoWXZlZq0H9GdyF2K6Y7jcw3MjVYNyF3WQrDiy5lIOSBiGCsRRcZnTyzRLUopTU+vM0rO1pBh3q0BU5AmnHD+9UQPC0NHycinntIqkdklxivvPa4eQb+Z26IYUumhQezB8hQSnxnBM7doi0+HEyp3PldEX48nfFqT3JGGQV1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786101884; c=relaxed/simple;
	bh=1bJrQdoDJJlnYPeQhM1gZaO3AapKytI+Anwh/AUi2a8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O0Oi1WWDvislaEiCbhiscIvXPIu3Yj5a7BG6Vgt7zhRh3obEzHl8vfyY128HlSNPbfXKbDvDsVlVCrJGOFZLrnVjPKEslHh97ieAiJpnc/uZdFbLadVINh37RUvsoz7XRPO9u3LsMpnPi1sjoHIueeEVlAgzKbwJ47d+N42nFng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org; spf=pass smtp.mailfrom=flapping.org; dkim=pass (2048-bit key) header.d=flapping.org header.i=@flapping.org header.b=QoQ8eDhV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GTD+qGdy; arc=none smtp.client-ip=202.12.124.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flapping.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flapping.org header.i=@flapping.org header.b="QoQ8eDhV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GTD+qGdy"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id 6430B13000BF;
	Fri,  7 Aug 2026 07:24:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 07 Aug 2026 07:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flapping.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1786101881; x=1786105481; bh=0xEKjxQ5miH9a4/azPF9P
	KTqxsokQze1z8Q/PdPKxt4=; b=QoQ8eDhVLC9Vt7hKPuaqemZcFoAs0Kiw/pfVv
	AB/NaSwrnmJNzaMm6aWNNmTpOJgADcW/FOf31DetNWXEuhtA4Pwur+nCi7krFfJP
	0clPKzU1Juy0tU2SD9GaYACMOWqYQY91HUkh7LneK2qKXsFMuugctjQNmymJVCvy
	pyka5SBTMo2FS3avpYoxxP9sn4l32uew0ypBnXI8zAJ/C9KoWJqWNSpeFF+/Wph+
	MZfLlTsRzYcjVHAh9PqllkndPH+iKpxJtDWEUWXoaqCUJDt1W6z1o7yZyDrfOx67
	gRYlgJ0xvcspVEzFdnAnzDOuEwQ09zwEUVBnEIA97A5/QPA2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786101881; x=1786105481; bh=0xEKjxQ5miH9a4/azPF9PKTqxsokQze1z8Q
	/PdPKxt4=; b=GTD+qGdyCdOcwlCo/u7pdEGkKhlQeSzrlGHavQqLgUvEhHtf+VO
	/CiKWpDUbPysyy4Do15Je2jy9axG6dv+POgkjAZkbDHFjofqCU4ZXQbXzb/vEzbQ
	RT96/TZRRh/tO4qqXM32uM3XtEla0viC3+wgOufyXtcEo/l/sEfXPJpbZ4NJi+xW
	DjuDQ7IAqSi8d02pEQW8nmPU2TBbR/6NgtjjW4wZC7syK1wk1kPjvGAn0Cfie0kD
	N0H/weTsXml8t7jP/r5q8G180s/p3mGuLIBG/ZZPJlX+RPOzOSGgA+/ivjMthfi5
	dRznGw7tKOJUP6aldzDe3ukRHFvz4AmI2Hg==
X-ME-Sender: <xms:eMB1agqtbAAp6h2QFn-SYtngNWMTkBYAjp3e0EDapsvWtsna7hwKWg>
    <xme:eMB1agD1WtSDDC5Ni5lRJwYicLYIqV56l3irOviZIHZEQMteie3h9nSV-Ypw5EB0J
    TtWN9zUctXMRr8hUUmkGIZRmy4i96hGW3blw8VomzUQ0AfJrn9ULLA>
X-ME-Received: <xmr:eMB1atuO184euk5QM8Z06xljarC1jrhum2aGPzXfaNYVpGLEO-lJhKIOkmVgqWuIswZkS2vBuejWrL0NWWg>
X-ME-Proxy-Cause: dmFkZTEsyOtrOo/DVG1jV1Yyg+uwMSyF/kUvXIC5gYjYOfcO/bw8hBFtT2pjrbeys3iWju
    P0dUuqL0B6Dd2G0KTJviW5I6QPHxFiQUxMsQiCwRNxFrXUobY1lwcR3a2kQBmyha4mlsAZ
    frGvaGgtORBNFDv7itC4EZ5i/tekKBLDfBTqkdpUnHMDK6277uVEEAyTCD0GkvCYM8Vvu5
    07fsaokwia8hnnrV9aM/K8OfaSSTdfnkXqT/hbOiau424GJRopD6hx11gXaWt6NJNOK9cY
    1fajYVfMA1iHhf0TgymWCElufm7eeEbHTpjw2U3LN4MuGpi6VPXrLJZ8igFpRDYfgGUsOS
    7IIdomA9Q15cP0l/F0Hh25JBgm1m6N8K2xmF+u4RfztfeW2oA1RdicBHdxM4p14vT7qb2A
    lJgiSUZMA0M0D4Yp1WJCRE3aSwAw7fRbv0jP3WF7EJcT7+JAQ88+GIO29S2ZgAH6/GWNze
    XdcSkf5bmHW3evH+zkSi7y6IDd1wOCvATOQMCQHlKNAv2gm1xhXeFkz1s+GyNvchihdTVs
    qqKjZzcooG3GGAvY566lBH57mOdy6/GjV2mxq3DEmaaYHNVo7M0Z8yHH6kEhU42AeS66fg
    Mwd1FbAOz0CRGKJy8dREQZF/ftlecDtcE+AmYO96YbZGg8IbsdUUs+6c+lKw
X-ME-Proxy: <xmx:eMB1anYTPZQQzzuHU2GzjV254hzArnbRFaRLzHub9lUfg-CTDBNHpg>
    <xmx:eMB1ahFT8iDKlhVTFBboaQW7vFe648wZnsL7xUsveZzhSYG93LILvw>
    <xmx:eMB1aipu_Lxew97xp0ZegPvdtZ9IwgrwS7alNe_uvOKk-lht_LAjKA>
    <xmx:eMB1akxGIve1naxe78lFdL2jkaZUdbZ1mqE0m0WAnoUdtPGnk0dKAg>
    <xmx:eMB1agS06HFCGhsPhoUj6kGhlNlwk5P1y0iHMooxlqdgI2HpA9WZwG0e>
Feedback-ID: i51fe4b43:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Aug 2026 07:24:36 -0400 (EDT)
From: FUJITA Tomonori <tomo@flapping.org>
To: ojeda@kernel.org
Cc: a.hindborg@kernel.org,
	acourbot@nvidia.com,
	aliceryhl@google.com,
	bjorn3_gh@protonmail.com,
	boqun@kernel.org,
	dakr@kernel.org,
	daniel.almeida@collabora.com,
	gary@garyguo.net,
	lossin@kernel.org,
	tamird@kernel.org,
	tmgross@umich.edu,
	work@onurozkan.dev,
	rust-for-linux@vger.kernel.org,
	david@davidgow.net,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] rust: bug: fix warn_on macro build error on UML
Date: Fri,  7 Aug 2026 20:24:27 +0900
Message-ID: <20260807112427.1039056-1-tomo@flapping.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

From: FUJITA Tomonori <fujita.tomonori@gmail.com>

Callers that go through `kernel::prelude` have `CStrExt` in scope, but
code inside the `kernel` crate imports explicitly and may not. Using
`warn_on!` from such a module fails to build on UML, which is the only
configuration where `warn_flags!` needs a C string pointer rather than an
inline asm bug entry:

error[E0599]: no method named `as_char_ptr` found for reference `&ffi::CStr` in the current scope
   --> linux/rust/kernel/bug.rs:83:49
    |
 83 |                 $crate::c_str!(::core::file!()).as_char_ptr(),
    |                                                 ^^^^^^^^^^^
    |
   ::: linux/rust/kernel/time.rs:427:9
    |
427 |         warn_on!(self.nanos < 0);
    |         ------------------------ in this macro invocation
    |
    = help: items from traits can only be used if the trait is in scope
    = note: this error originates in the macro `$crate::warn_flags` which comes from the expansion of the macro `warn_on` (in Nightly builds, run with -Z mac)
help: trait `CStrExt` which provides `as_char_ptr` is implemented but not in scope; perhaps you want to import it
   --> linux/rust/kernel/time.rs:27:1
    |
 27 + use crate::str::CStrExt;

Call the method through its fully qualified path, which resolves
without any import at the expansion site.

Cc: stable@vger.kernel.org
Fixes: dff64b072708 ("rust: Add warn_on macro")
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
v2
- Use the fully qualified path to CStrExt::as_char_ptr() instead of the free function
v1: https://lore.kernel.org/rust-for-linux/20260801022501.722493-1-tomo@flapping.org/

---
 rust/kernel/bug.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/bug.rs b/rust/kernel/bug.rs
index ed943960f851..40633a516a8f 100644
--- a/rust/kernel/bug.rs
+++ b/rust/kernel/bug.rs
@@ -80,7 +80,7 @@ macro_rules! warn_flags {
         // with a valid null-terminated string.
         unsafe {
             $crate::bindings::warn_slowpath_fmt(
-                $crate::c_str!(::core::file!()).as_char_ptr(),
+                $crate::str::CStrExt::as_char_ptr($crate::c_str!(::core::file!())),
                 line!() as $crate::ffi::c_int,
                 $flags as $crate::ffi::c_uint,
                 ::core::ptr::null(),

base-commit: 075b74841bd0065a3bda3440873c747938e69b68
-- 
2.43.0

