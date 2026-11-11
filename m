Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794365005;
	b=cgry98MEpouB3oivieyzo/fU8QFmuL8bhB+a1Zr8cUbPHRctbMM9ozGSpmaNzdZJfyoM
	 ayK/3uYNKlZQKmNKr/Qlo/uyc0AV3Wb158djCWhUXYP8wC48ORy9v4th0pNkGpM+xz+WT
	 m3RUZmiMkUzSUa/eX3D51xicDpjbuV9ybe44aEAXrYxfANQPtZQC1eD92ugvO3ac8Ea6P
	 Eg+mQICFFtPkVeXgz0FT17ydm+CkglMoO3sWTSqam8FndfDbhyImjNGWG/6/v5YqFLul8
	 vJv3hiejU3MDftS4L5sFLcXSpJnWhmpjESzpQ81MMm9nDdUzFPrpRR8oGsuRR32Sfuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794365005;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=jpakjmHwg6YmZ67PJhRYMdIZyk17kR69BsbWI335b/U=;
	b=CDeyLfBlOA1b565pBb6hEk3pLm6sj1W1vKQ63bNNRL+2RFgSPK6SjviMsNzsXbLA+l8T
	 waSzNq8c4NXgm5cFgfCkE29uqzUyi9fdG652F0NOHAyWJOYTCOZ+/HVkL22/3oX5NH+1l
	 u+9C1KW6+Wr8PINeguFkCTGtOuUooMci+NXjtXL6PGJ5xt918ujcfcL5m0pcj6/xL0463
	 0qKAKDb0ldncBPVFpkawEQx0a1mf2YttriME1PRByeFU+oxqlp7N1N0R5HSbpEoPKoeZ+
	 9go31D9HOwm/UPEX26Nzc+J7hx0+RJq7E09MtElwXOLRgV0m3sUAtfQqxE+8o2Fl3yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jYd2OAqQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D87606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jYd2OAqQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5412C1F0089F;
	Wed, 11 Nov 2026 02:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794365004;
	bh=jpakjmHwg6YmZ67PJhRYMdIZyk17kR69BsbWI335b/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jYd2OAqQf76sna2fVnK1Ep7Hyrz/X6VSbofVCJDROeWdxq5hkmV06YIKsmTAsRHwz
	 l5cWJ9IOyZ23qEuwjy60tq5OYhgyaQq1i/NEGTmvpL9S1KWcOthFAVK7e8WfG85w7x
	 XlzbDJNFyylzP4w7BqQ2pUo1U2UJWFix2R9T6B8ILRGa97a1liqBKGAit+m9g9K28d
	 n2rInUriMD1i9jXAaDhXpyyOn9mwJj2404VP8lDCQrETHTjG5+uQ1KBQL7TMFav2vm
	 aj4xoKJuVTuH7q8y/QWSVCRsWjlQYeDf/4WOpxVj0yowxllmW0e54F1VbfUpQGF7/2
	 Ekupxt8qSl2fg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/5] KVM: remove more traces of device assignment UAPI
Date: Tue, 10 Nov 2026 21:43:19 -0500
Message-ID: <20261111024039.676658-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052838-failed-6.6-eacdb76c5f04@kernel.org>
References: <20261107052838-failed-6.6-eacdb76c5f04@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Bonzini <pbonzini@redhat.com>

[ Upstream commit c0a411904e1548d287dc4a031ff19d00e0569202 ]

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Stable-dep-of: eacdb76c5f04 ("KVM: x86/xen: Enforce 4-byte alignment of vcpu_info registration")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/kvm.h | 50 ----------------------------------------
 1 file changed, 50 deletions(-)

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index e48ba56c54858..3a158e6d12e24 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -2015,56 +2015,6 @@ struct kvm_sev_receive_update_data {
 	__u32 trans_len;
 };
 
-#define KVM_DEV_ASSIGN_ENABLE_IOMMU	(1 << 0)
-#define KVM_DEV_ASSIGN_PCI_2_3		(1 << 1)
-#define KVM_DEV_ASSIGN_MASK_INTX	(1 << 2)
-
-struct kvm_assigned_pci_dev {
-	__u32 assigned_dev_id;
-	__u32 busnr;
-	__u32 devfn;
-	__u32 flags;
-	__u32 segnr;
-	union {
-		__u32 reserved[11];
-	};
-};
-
-#define KVM_DEV_IRQ_HOST_INTX    (1 << 0)
-#define KVM_DEV_IRQ_HOST_MSI     (1 << 1)
-#define KVM_DEV_IRQ_HOST_MSIX    (1 << 2)
-
-#define KVM_DEV_IRQ_GUEST_INTX   (1 << 8)
-#define KVM_DEV_IRQ_GUEST_MSI    (1 << 9)
-#define KVM_DEV_IRQ_GUEST_MSIX   (1 << 10)
-
-#define KVM_DEV_IRQ_HOST_MASK	 0x00ff
-#define KVM_DEV_IRQ_GUEST_MASK   0xff00
-
-struct kvm_assigned_irq {
-	__u32 assigned_dev_id;
-	__u32 host_irq; /* ignored (legacy field) */
-	__u32 guest_irq;
-	__u32 flags;
-	union {
-		__u32 reserved[12];
-	};
-};
-
-struct kvm_assigned_msix_nr {
-	__u32 assigned_dev_id;
-	__u16 entry_nr;
-	__u16 padding;
-};
-
-#define KVM_MAX_MSIX_PER_DEV		256
-struct kvm_assigned_msix_entry {
-	__u32 assigned_dev_id;
-	__u32 gsi;
-	__u16 entry; /* The index of entry in the MSI-X table */
-	__u16 padding[3];
-};
-
 #define KVM_X2APIC_API_USE_32BIT_IDS            (1ULL << 0)
 #define KVM_X2APIC_API_DISABLE_BROADCAST_QUIRK  (1ULL << 1)
 
-- 
2.53.0

