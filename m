Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C30A4D2ED9;
	Wed, 30 Sep 2026 12:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790771869; cv=none; b=DyjuZpzCnYTUFMHa0LfCude8De2FXHVOOtfl3SmCe4VcUdzW6Op80Y757SGY52/DG87Pd9uLOCiYaPb72i5SbhrqlHI4BoKEVZ+9FGbDj/nAxBvmE8sJwG2TSWP+nmdp6IcpF9wqMs33P8SRQdQkglR36YJP+OhtckrD7blsi+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790771869; c=relaxed/simple;
	bh=edz9FRHFEdXjiZlyhC0DEDidDuGVFt2A08iesX+0vVY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ty/vMvbqlf5B82ifu8tKFeEn9IRNRote9zfhM4qQ1Zzt6csw6Wv6mYZWqXkxX1v+8bN2CD8XywVVjPNscHaaK0m2WsGRiTe8tGRroD/xJxbq7ikaJexJXVG5kD4mAk8zyGOA1Toe3CE5x9bjcjTdMysGZW0AfDMpQodilEwMv2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FoyUwOig; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FoyUwOig"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8255D1F000FF;
	Wed, 30 Sep 2026 12:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790771867;
	bh=DepFgs+v/Bioeks1soXkH0LShlVH9SuMmPSryf+3zaY=;
	h=From:To:Cc:Subject:Date;
	b=FoyUwOigc+1EnsYpkfJS9PW1cMQqW2kUe/BAa+sys2pVEceApJzZPuu+SH8zva0kR
	 29GONfDMrPaSYjuqCOjG/4F/LShSarpXIWsGHKV7PF6zUPBnNK+WV9jfcj81eMNkrV
	 lTwuNz+NynX3PhLPDjRCc8HVmjaEJHfreFnhNKvSXYTc6rkGIamxLePupDYVI2LRdU
	 befYUtGu62ckZTL+hxh7S8mMEmtb4XhO5lFTpBm5ZW6/PcDrddt1AH8Ax/m46MCYwK
	 nZ7PDrCKQGTlCrMSCB+TfgyawU4LxvbnV+fD8RpBe7J24UB70llSEphEeNgYSxuwll
	 omDnAzFq0qABg==
From: Miguel Ojeda <ojeda@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	linux-mm@kvack.org,
	rust-for-linux@vger.kernel.org,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	stable@vger.kernel.org
Subject: [PATCH] rust: bindings: fix VM_MAYSHARE blocklist entry
Date: Wed, 30 Sep 2026 14:36:45 +0200
Message-ID: <20260930123645.302318-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 2b6a3f061f11 ("mm: declare VMA flags by bit") added constant helpers
for the VMA flags and blocklist entries to suppress their direct bindings.
However, it listed VM_MAYEXEC twice and omitted VM_MAYSHARE.

Thus fix it.

Fixes: 2b6a3f061f11 ("mm: declare VMA flags by bit")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/bindgen_parameters | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/bindgen_parameters b/rust/bindgen_parameters
index 8402b0c93545..93e622aaaf78 100644
--- a/rust/bindgen_parameters
+++ b/rust/bindgen_parameters
@@ -50,7 +50,7 @@
 --blocklist-item VM_MAYREAD
 --blocklist-item VM_MAYWRITE
 --blocklist-item VM_MAYEXEC
---blocklist-item VM_MAYEXEC
+--blocklist-item VM_MAYSHARE
 --blocklist-item VM_PFNMAP
 --blocklist-item VM_IO
 --blocklist-item VM_DONTCOPY

base-commit: 7b5ba47d845f35b04937748a191a1772ffc1f288
-- 
2.55.0

