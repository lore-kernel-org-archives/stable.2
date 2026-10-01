Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B4F3161BA
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 12:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790857882; cv=none; b=cj5zzcU/qBWriTYPyaCfOqxiWzF5DMuCJ4FLCuBS37MidrsPwI91Jlg3dD45pZkRyXu8L6zfrPEufDdpFpcPJBdBYT5A8cQc0rG7jjUpHWwuTsf9L9gfdUekirlCp2tNcvHy3t1Vb93qihDBpOEc3MPEEIEw09XS3lFVsvyu+Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790857882; c=relaxed/simple;
	bh=twM53lvJ3VhYvfBx9KT0LL7hdlFMgjTFuP5pELddS2k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dua7pNTGOqWz3Dx5xycVZYk4Dm6TNyHoJugteXPHwxJj64O9xZ/5Gga3qGpePjgsZjP7mkpAhtCuaqPcxxOde5tkR803OTepBUq4GnTWVA4vTsT56u1X471aWCi1B1VXPrHam3A6n7ewuD5pQcyLgoJgHR04bLk5Qn6tOfcQYIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org; spf=pass smtp.mailfrom=flapping.org; dkim=pass (2048-bit key) header.d=flapping.org header.i=@flapping.org header.b=RltVOv+i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q/YmZUJU; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flapping.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flapping.org header.i=@flapping.org header.b="RltVOv+i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q/YmZUJU"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BE705140012B
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 08:31:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 01 Oct 2026 08:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flapping.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1790857879; x=1790944279; bh=Wc/XaUzu4zm/FTuCYjNq4
	8N/EyN6DPB0fjJUcT4PstY=; b=RltVOv+iFl019WFm9zEwIUhx3rf3AwFVQJlCW
	IazUo/S+EQesb0BLvYiYiYGLHu8xPjg4jw9F0yS7fHuvHjgSL0NEO+qQ8rJrg5Vv
	hG6wWPjhLDSwoOKvOvCb8+BKsfiPxPRKeW+xP+nPTnKwYtdX0GYJJK3lVWNgJ2Pz
	FG4AFufVVABNpN6ELLQNxvggGlFrHzkoHAFtlpQB9REYNmMjIN/mVSQlYHGN32Le
	zM8Gki/3DP3Uwie4qMKXTuqnzInXJrRBJBW6wRmInzTmbegstJ+0xCwL9r2RAfTm
	PjCVWh+wITUOGQ6j6Wv0al0Pw319/GMOmZgkK3um3t29sq7sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790857879; x=1790944279; bh=Wc/XaUzu4zm/FTuCYjNq48N/EyN6DPB0fjJ
	UcT4PstY=; b=q/YmZUJUI2/0HoWoK3pW3kEW/fMxFzaL97MVprN0fm4P136VAwJ
	L/I8DTApGqo/iMHC/DARgPuLjkgSgI7qTevUPjo2kmwOSG3SUc0cyXnMftCA3vR8
	RqLqoIsNnngf1X6O4TmLyDz78Sqdjt4p1pj7dQxqjiG2thpEVQcYawIRZXayhoqN
	QPpeUZuwrcV9C3umKVSxXm84+DNm/wAeoG9eQUdbojIN6n8IVpJEng6YN1jeEQ+F
	cI3ToRBjnJ8kpu3ekBsNZKeCLr2hNVyrr13Ve+xeKdE6JHy0rkkNkd/jw5h4QYl3
	TUCk5E6YycIpjSk2sOG9LZ5uPFISgpeNhMg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=flapping.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790857879; d=flapping.org;
	mf=PHRvbW9AZmxhcHBpbmcub3JnPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:KdQu4FoRw/tfoUQbm31PubL7yPbSWpB4bul6xFxQ3ke7C01
	VN+yuIUaHhjXqEA6ClRhuUiw7W5MBbLGJQxv4yD0aR3uJz3aZz73nyiRntdISJCP
	eUzKKc8LsdwcnLi9+yEG9YyC89vVgQ/4Mn0QaiWQ4RzXtluzzpMzs5Gi6vOyXryp
	tN1/WneVfrtgH6rwr162CWD2q8MaWg5B8klc3215Vpo6IofuzM6dGSlpA6CgJ45S
	cqupCd+7xDwxwvIgjE+8MOHr64PWItioGEBMH5K/SFq64+idA9bEUiJ5niBeTYQk
	LA65k/SSHryu10iHhPMkoE32E3pyixIyf3PCmWQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:elZ88t6N8IC91EdShLwDg5uZGEGWOCpiT01GTlZ8A0k=:twM53lvJ3VhYvfBx9KT0LL7hdlFMgjTFuP5pELddS2k=;
X-ME-Sender: <xms:llK-aiF47X1ORNVVTOHiWfYl5KKkTnfhmZaiuzKR7EX-wbgyyRXthw>
    <xme:llK-aqZi0RQljVCyoTnth_rpM5vE8awnwtqLS3hBIvK04PlZH7GdJgNeHZNUqm_aR
    SsBdMJAgxBg1xsOMkFlhta2bFPw5_DX3-au-pscIhcBX9r0_KS3hqLP>
X-ME-Received: <xmr:llK-aj1Gmup7AhY5sGj6MKXhU9y60zKWXArB60JXymh9EAfoMiAkBJKl-RVqh7g1BEn_czdSp98gYMPaqtY>
X-ME-Proxy-Cause: dmFkZTFwS70LB3erJYzbaTJsyLPdABAp/zeskGV2WMC+BSrmSlE9v0pqkD/yg1RYHMkSNn
    I7wLTPwb90zziHO/mKGNl2k67luwVI4dTo6f40kR6JVbFk/T7h82hO/07U2LKJJkLwnxGZ
    KXODYm9O6Htiu9yUb5W0zYNr3iuXfKo0ACrU4QRJD2hE9SHbeV8hFTYJ4uLBQZG1ZiAgma
    iA1ybPD1zBZ5uK8zNsifAzmwSoJXmHWyiDc73S1YRr0pa0ig0R/Q4z6/40tFsaamcegK2i
    WsAq9X0kaYu4LVu+Pkd5PdnM8DBhWkf3bx7CQO+b4cegfnJF8ry2prnHQEKijVcDETzNSN
    udpUm89d9L7IrEtYQb4s8fnTbcU8P+mPrDav0dKmbl9s+Ko5ES/WcPFTyHJLKxUCQzDecx
    bKy3mwYKe8ow+bIvKkoNHlNW9L1K1KQTLYsh9BDa1K3fUgZXySstfePWJPSvdwOxPJ0Y+p
    Spf0V7Eru5YH3OfAhn8zazMmb+udVmsDSft7dga9hCMWAhBp3Wh38oIg7WNL5fHs5cgaEW
    ePEwzspA2k3wI3hKVjGE0lcAEOCRpAuEgUiJYsqOjHMwivbqzWtJaudp9lh326DlnVYLIL
    lSkhJ6zyeg08K8jYl8ErM+rXTlCBVk6js0XJ3c8TUR7dGicgGaT3Tg9onuKw
X-ME-Proxy: <xmx:llK-aidqFe_5go7kpExN4t24SlmAvaaPURI-553oUgbAakh2U-V-VA>
    <xmx:llK-alBKKza8lqcFWfs54IeuRTl5g47tNXycj1pCJPsu3xl-orTMVQ>
    <xmx:llK-ak01xHQ3m5XSmknJ1cMaKhgl7TNvyuTGoTRqbTD3WlBNFJFh5Q>
    <xmx:llK-alPkmIPC1XPPkCRXK5zjVVGZOg3y6OjpeB5VLSC0sVvdbTiZdA>
    <xmx:l1K-av4OhgThdwQQ3S42Pi8iX2B5zb5F5uRZDWmLiVp1PrlNL0Vz9viR>
Feedback-ID: i51fe4b43:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 08:31:13 -0400 (EDT)
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
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	linux-um@lists.infradead.org,
	david@davidgow.net,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v1] rust: bug: pass TAINT_WARN to warn_slowpath_fmt() on UML
Date: Thu,  1 Oct 2026 21:31:03 +0900
Message-ID: <20261001123103.2198104-1-tomo@flapping.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

From: FUJITA Tomonori <fujita.tomonori@gmail.com>

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
---
 rust/kernel/bug.rs | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

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

base-commit: 551c722f40809618230001baccf219193e22fc5a
-- 
2.43.0

