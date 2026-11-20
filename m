Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795195178;
	b=fm0QHNntoZ5kLNE5Rg27JBndpJQXs05uBiiwy1T+2yO15NnknA1hyi/424HUrZdlZqGe
	 7k9biDWvNpghoOPeI6xoIXxUiqBH3cjBkQtbqh8yAAUX3XFIyQ3EINYebqTf83wgA3V1D
	 e0SYe8X9NChk7I0JPLOmDbqCzSVOlv30HtVgArevDLIno9vgPDq95FB2a1kAe6gjiIuJZ
	 yn+WhZcV3SVhwU/6DiTPqmG09ofnVntxlUeWOL1/RaQOq2JIEmlmZ0YAjVl2uwqB4DrO4
	 AnOh0sSHFu0Fo3F2ibmsBa0IcwPYFj+dEAEdOAU+c9g8yEqJtZCIkNViLwneZ8oMadQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195178;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=2zcrVQeVXJas3x9RQbNjgW1QooapoxIa+ujuUqI6vCc=;
	b=AuP5mFWDGcwVi2Yjq1M7OdYEV/G8VHMwKJAEiufRAFLsfFHxC6/2d6t97dx5/nDJrA2L
	 rPvUnuAowLv+PKn88ENWD/MOK1r7IjuN0cTFJpIi36e3Y9UJs5vsyCwQJhlsuTt1Pszil
	 FnQBmJvUCcuyGfaeuf+O8hRdX0FdWwfKxwFfTCTa3YM8D0thUXNkeSeiVidPitfXj6H/N
	 MHo99uLjll1Dl/B0CdftCLe8yOWzkSPT8eaMpYJVYf4NUAgHny75YZcVxdsPvofPLIoUe
	 O0k3bryu+YjqsckGoU/LxsmOaU+G9zP0QDtlXwoiIGQiIgthm13h4xN7/0NuHi/us1g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z8v1Xxd7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8B860A2602;
	Fri, 20 Nov 2026 17:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z8v1Xxd7
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795195177;
	b=SglsH1vQS6IJt8T9y7vRjDen9ftjATSEtb9exhAhK5/C1ZQyLg5TIT5RzqhQgfLdKBXF
	 X0K9HDDJyqQj2qdxk3IHp2gRBaWhLYVQWoFPl8IJGzvBK0rnhr/wAHypkFEP581pvBXhy
	 Rj3a5CN1fJzqncf1ucC4mYa5BWPXdgSldiZ4vYF9K+PcEcnkd+pfSfm0Ln1HH81+lmldZ
	 CAtHLlA2yXeRIfruE5ky7poWNM9nAj2L7jdRCd0/vPuOJ3afTX3dtREgL7g1EHUQCddOB
	 mdSYVGPSsa3th6RFVsdkDcJIXvXr+uvnA1OTNMfcntf102n9HqpN/SAn1sSqnNvtN0g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795195177;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=2zcrVQeVXJas3x9RQbNjgW1QooapoxIa+ujuUqI6vCc=;
	b=GJsH9VXqBtv5AiYe1r5Im1qNE1VpeS+eKSUIDDruZkfpmJ/1VxYzHzsKvnWY0vqq86Mu
	 iU++M8LKexEGjvp3MCEIY8Bdv4A7lp4ZML+jeE/TB86I2q04I72YNVuxMSPSuC6f/ZA8P
	 bKHkHuPG+41FDFyQ1Xfn6XLzwSx9mJKiMiKWUxJYPte4FXAEyHKSvOpTXkpsWZZkc9S41
	 7eHJaEOHHoRVtqlCxLWNeJ8xVBorRfXTVG4p0yikxPiXs1tSDVbD9uWrfdDbzcPTSD16v
	 KM5jnz+TOORlqkrx5ebd4/OCX5F2y9DN1amyL12vZg1A/NNPJlo6rv70dQVince59dw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 08BE51F000D2;
	Fri, 20 Nov 2026 17:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795195177;
	bh=2zcrVQeVXJas3x9RQbNjgW1QooapoxIa+ujuUqI6vCc=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=Z8v1Xxd7V7e72HcIevlDidUk/qBqw/0ewkze/C9b4Ww0HbcAVMUOl/4NdUxohot3y
	 Ver4PoVQzC15Ss2Pf3g9248pFcrmeA088+4tkz/0nPzsvGEtNgDa+tab0+BSF67TYx
	 LwY2rZwn3B8xTZh/vgJYW2aDsidWxKI1I3hwPG+reAnll/uGV9Ie8CsFWX4hqYWIRB
	 Nx+hgYRVhf1Wsu0jSuv9/Cc+dKCvVSbJbhXelKAjlYTaZdL2pSajyfDPc+TnBJvVY0
	 tBz5Ke0+un6EcK5y85TgBhFySSBPgoYusZhjvLsntFv5mh1xyIItFXkBItq4fFE+en
	 dQp0MxhcWNilg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8E6AA4B867;
	Fri, 20 Nov 2026 17:19:22 +0000 (UTC)
From: Peder Bergan via B4 Relay <devnull+peder.bergan.gmail.com@kernel.org>
Date: Fri, 20 Nov 2026 18:19:17 +0100
Subject: [PATCH v2] rust: bindgen: Preserve sched_statistics alignment
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
Message-Id: <20261120-fix-schedstats-bindgen-layout-v2-1-1c42e4a996ae@gmail.com>
X-B4-Tracking: v=1; b=H4sIABSBAGsC/42OTQ6CMBSEr2K69mkLosGV9zAs+vOgNdKSvkI0h
 rvb4gVcfpOZL/NhhNEhsevuwyIujlzwGar9jmkr/YDgTGZW8eoshGihdy8gbdFQkolAOW8G9PC
 U7zAn4G3dqPOpPl34hWXHFDEPNv+9+zHN6oE6FWlpKEkIKkqvbYnmiVJEOR7jTAk8vlIpWUcpx
 Pf2chFF9u+hRYAA3rStMVXN+97chlG650GHkXXrun4BQiKm3wEBAAA=
X-Change-ID: 20261119-fix-schedstats-bindgen-layout-0935b6434707
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Carlos Llamas <cmllamas@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
 Jules Mercier <jules@les-mercier.fr>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795195162; l=2723;
 i=peder.bergan@gmail.com; s=kernel-contributions;
 h=from:subject:message-id;
 bh=u4QY0eOrLq5AnKKXDQlNnc7y1G/bsdbLKO4Tsmnc1Rc=;
 b=CGjLrC3xrHMMhwNk+60mTkOfXvVww+NtfWTp4WrSpTz699eWkTcZfvLHqQl0ZqdN5766bwcEE
 9/I4tueXlvnA7tRsCj0He39kTVlIwcEXrORV3Rogf331Je1IwEuSJFa
X-Developer-Key: i=peder.bergan@gmail.com; a=ed25519;
 pk=39790pn1YZCulHBoUG1uiQI1Hm01EvhBEa2zVrS/yN0=
X-Endpoint-Received: by B4 Relay for
 peder.bergan@gmail.com/kernel-contributions with auth_id=1395
X-Original-From: Peder Bergan <peder.bergan@gmail.com>
Reply-To: peder.bergan@gmail.com
Content-Transfer-Encoding: 7bit

From: Peder Bergan <peder.bergan@gmail.com>

With CONFIG_SCHEDSTATS disabled, struct sched_statistics is empty but
still cache-line aligned. Bindgen omits the alignment of the empty
type. Bindgen 0.73.2 also stopped forcing padding before over-aligned
fields, so fields following stats can be misplaced in the generated
task_struct. On the reported arm64 build, Rust Binder reads the wrong
pointer via CurrentTask::mm() and rejects mmap() with -EINVAL.

Make sched_statistics opaque so bindgen uses the C size and alignment.
Rust has no callers that access the fields of this type.

Reported-by: Jules Mercier <jules@les-mercier.fr>
Closes: https://github.com/Rust-for-Linux/linux/issues/1269
Link: https://github.com/rust-lang/rust-bindgen/issues/3549
Tested-by: Jules Mercier <jules@les-mercier.fr>
Cc: stable@vger.kernel.org # 6.12.x
Signed-off-by: Peder Bergan <peder.bergan@gmail.com>
---
Changes in v2

- Explain how the bindgen 0.73.2 padding change exposes the missing alignment.
- Link the bindgen bug and request stable backports starting with 6.12.x.
- Credit Jules Mercier's report and OnePlus 6T test, and expand the Binder Cc list.

I kept the opaque rule unconditional as discussed. On bindgen 0.73.1,
I found an offset mismatch at task_struct.se before sched_statistics.

I also checked an arm64 6.12.y build with bindgen 0.73.2 and schedstats
disabled. With the rule applied in the 6.12.y context, the Rust
task_struct.pid offset moved from 1208 to 1216, matching C.

v1 on lore.kernel.org
https://lore.kernel.org/rust-for-linux/20261119-fix-schedstats-bindgen-layout-v1-1-0599dd230ffd@gmail.com/

OpenAI Codex assisted with the bindgen change, validation and drafting.
---
 rust/bindgen_parameters | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/rust/bindgen_parameters b/rust/bindgen_parameters
index 5bab3cf063360..65c308d4b603b 100644
--- a/rust/bindgen_parameters
+++ b/rust/bindgen_parameters
@@ -26,6 +26,12 @@
 # warning. We don't need to peek into it anyway.
 --opaque-type spinlock
 
+# Bindgen omits the alignment of empty structs. Bindgen 0.73.2 also stopped
+# forcing padding before over-aligned fields, so following fields can be
+# misplaced. Making sched_statistics opaque preserves its C alignment.
+# https://github.com/rust-lang/rust-bindgen/issues/3549
+--opaque-type sched_statistics
+
 # enums that appear in indirect function calls should specify a cfi type
 --newtype-enum fwctl_rpc_scope
 --with-attribute-custom-enum=fwctl_rpc_scope='#[cfi_encoding="15fwctl_rpc_scope"]'

---
base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
change-id: 20261119-fix-schedstats-bindgen-layout-0935b6434707

Best regards,
--  
Peder Bergan <peder.bergan@gmail.com>


