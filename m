Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794938227;
	b=pUBLUajDLTj3FNaq8+TWQptZifk6WCYBLOY6PhhAiY8v9yAEoUrkYL9tCO/aUwsOG+lf
	 A/PTIWyugtqJFU0v16RPtCItKIyeJl8mNEH8BXiDBMFJ6DSVm6OGA0WM3+Zo0fFTq8xKg
	 NizAjBAJQbuAEc0QCe1m4iY4VB02q8fxQokPNqmRyxe7uwumx9YBqf8QbrNIH+DeGtZDO
	 xdDdUxGjrBW8geyLjTmM7Lrgt3CBZDfWlm+gfdt48E9zrJlyhk1NnKUlN8Npq2omDczTP
	 kLWxxBn4u21jQP0nqu11EWuuvRLyDltUQBixkZq5dApk7AYCBlSpS2JhclaIWpfVphA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794938227;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=ArdsdUGdj0NMa0CZ1QhGoT5grO6+ssiW5NMN0otmSc8=;
	b=0UEqjn4MY5NQhCJVdzmSDdlfIM7kjtHTNUvOCYnR/Cbv2m9N/6/MuqKFlGSEAwYYCBQB
	 taT+a9ETMrDVzaoFqc09ERfRy3LTM3m9DzDYg/W4VH5p2WLkt+imKudgKmLJsEK2rhTP7
	 xA8oh9BALAUfES+bff/befnY16q5GFkBQGIPOHAEeWRFu76SPY67COl/BotCQvwICSpYK
	 zseXOiLtz+soEsgIph0eymKBAmecKF66X0YR2GrEv4dcNdiIBDHX3i1xRIANf2wYfUC3n
	 jr63fDfHLZB7m46FVCZCeibwlTEeNPJZWSQrwas9Ql+SZUHj/8ztvPEBKMgZgDb2ypw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UrscteuC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E641E606A31C;
	Tue, 17 Nov 2026 17:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UrscteuC
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794938226;
	b=XY86PkETJ8uO5rRiYRdlc8Zq6D4p5seX9OVzRxcDkIqi7QPTkmvvUQdOguZmr7TrJNcv
	 tgUBv6cFfWrmw0vh/3K0RhgToE40J00befBWueDg1CxcgxUfq9V1GvIFKC69jFNRLuB4K
	 O46bwaYbGtzi6qpDYnwGUDXfDGPPG4Ysb4TpMkoN9Wy+d5aB7XPC1dWs5vPXKUsnZHhIF
	 9Z1adKATnX1aFCPlZ/XILt7Bu+Ll7LVthz7zAbWZsyL90Tj7MSL3u+c56+jmxCkAMkvSk
	 Pdxci57eksxCPNK6zsTZzZGurG682Hu91+GZ0Mx1gxDhEDSz7KgBHwoLk2PJtAW3qIw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794938226;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=ArdsdUGdj0NMa0CZ1QhGoT5grO6+ssiW5NMN0otmSc8=;
	b=RDQTUwfIDkSQbBo92Gdv1voVBsTXZfNSOu+igAFaAkO2MOZQ2Ku9Vb7w/H7nvOM+5a5G
	 D6OF5/cWfg2lm/WVlW3/ZPwb3ZJKkuX4XbkRQlxGsQsziLG3Osdkn3DLfklIR4zoisW3n
	 ecDhz3Pi0JQaLGKi+F6jCcMVkCu4Og4AE4+DM9rkC1OhdhVM83v4fWOyacvsj3PvdhcW5
	 WYgMnBhkLZyoHfWN/xTNcXRdaDQph78b9DR+gKusIbwBluXRN2Y/Li64uzo6k1dNYIptz
	 fV855ZweGI6gYnX9n4BM3htFHm3jEgEQkO+9teleguMamnSbo3/Pc8iHEJoc5tBVi1g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3CAB91F000C4;
	Tue, 17 Nov 2026 17:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794938226;
	bh=ArdsdUGdj0NMa0CZ1QhGoT5grO6+ssiW5NMN0otmSc8=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=UrscteuCpN6jCdXD6reiUWTfRtaEiYzdIGem3Ll6FfnEtMC9AIst8wO2EdJ8GkEGq
	 b/0bjxFOvw1LKQYBShftp8LGBNFmIGzotYcevsTL4QghnDk49P62jYQhMrzVR/caLd
	 oNE3hy/sGRPFysWHZoenN43/vW7Tt58dsaPD2kzddpQiemTDPzjsBhek1/4ppsnCXL
	 vRSPuK1jNXTfERRG04fBu/cd2lF2vVuEOHoll5vofyodOVz15xxrxK1yXIAUl8tvQK
	 eV3ZgSZ1r5MDEzMAVfR2VOQic+nF6YQZ574+hidBFj3soCeiSiShKYBBC0uXe7AiEM
	 +5VEOKFZ/TN2A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id BD5C14A9E0;
	Tue, 17 Nov 2026 17:57:05 +0000 (UTC)
From: Peder Bergan via B4 Relay <devnull+peder.bergan.gmail.com@kernel.org>
Subject: [PATCH v2 0/2] rust: str: tie Formatter to its backing buffer
Date: Tue, 17 Nov 2026 18:57:05 +0100
Message-Id: <20261117-formatter-lifetime-v2-0-e216d86ffb57@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAHGV/GoC/32OzQ6CMBCEX4X07BoL8ufJ9zAcCmxhDaVkWwiG8
 O5SvHv8JjNfZhMOmdCJR7QJxoUc2fGA+BKJpldjh0DtwSK+xZmUMgdt2SjvkWEgjZ4Mwr1ISol
 trrRuxTGcGDWtp/RV/djN9RsbH0yhUSuHULMamz5E8+Q8ozLAs/Mw4upDqSfnLX/Oa4sMsr8vF
 gkSyjbXSZEVWZrGz84oGq6NNaLa9/0Lf1AmW+sAAAA=
X-Change-ID: 20261117-formatter-lifetime-48391ed7affd
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
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 Georgios Androutsopoulos <georgeandrout13@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794938225; l=966;
 i=peder.bergan@gmail.com; s=kernel-contributions;
 h=from:subject:message-id;
 bh=vp/LWvvmAzX34f8vnKcLQw+RL3iAYT/77OcdfbM1kEI=;
 b=eeZ1jr/xE+W8GNpkuqpEhdsS1+fV16E1iXTtLdK1DxWqokbyROdzfm0ed6J6RNc2K9J9Wqzsv
 nUaKFAL90/iCO3/qxvg9eqXLMrTMuf5m3cC3XNqHnc+lG3FdDNsexyh
X-Developer-Key: i=peder.bergan@gmail.com; a=ed25519;
 pk=39790pn1YZCulHBoUG1uiQI1Hm01EvhBEa2zVrS/yN0=
X-Endpoint-Received: by B4 Relay for
 peder.bergan@gmail.com/kernel-contributions with auth_id=1395
X-Original-From: Peder Bergan <peder.bergan@gmail.com>
Reply-To: peder.bergan@gmail.com

Split the lifetime fix and its documentation into separate patches as
requested by Gary.

I compiled the fix-only first patch with Clippy and ran the string tests
and kernel doctests under x86_64 QEMU. The final source tree is unchanged
from v1, including the previously tested example.

OpenAI Codex assisted with coding and testing.

---
Changes in v2:
- Split the documentation and example into a second patch, as requested by Gary.
- Link to v1: https://lore.kernel.org/rust-for-linux/20261117-formatter-lifetime-v1-1-9d7f38686552@gmail.com/

---
Peder Bergan (2):
      rust: str: tie Formatter to its backing buffer
      rust: str: add an example for Formatter::new

 rust/kernel/str.rs | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)
---
base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
change-id: 20261117-formatter-lifetime-48391ed7affd

Best regards,
--  
Peder Bergan <peder.bergan@gmail.com>


