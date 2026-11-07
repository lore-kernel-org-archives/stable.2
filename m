Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047321;
	b=Lv2yr9ZfESHH1ydXsK/eeNzy77Bc0s1OpQvh7zpj1CQuMDeO4VNqyqKoHmqtbVK4a8Lj
	 zkM1dvjL0Dlxduo/DXrhGTMqPdslG7f9zHCAcW8DvZ0oIpKRIrwJ/Kts/UEBOlYvuz0AM
	 Djb9EznG/DSMrn6HoIGEDI2ZXZp0eZlnwKSRsPnNpzDKOiSKkOU8Ywlw5GZzItxIKrVDW
	 pROoteSi0urJmDS/yPivHc70lr6c1FfYj5pcI3lmq/iFd5TiRJIXzoO0eg5QNOu8sxLfl
	 dcC85ra/zlGeV87EOwVUU8+cNkhEWwSFBkmNl4ia97oREDu4aAYSXBrRiz7tXJK3kFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047321;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=AiCubS16eynK3H117nThpdlBeXj03I2/d/0BU8Ci/bk=;
	b=Xy2Vm2rSD3Oj3sxnEOShMTHVzgizisQnnuSJWeigG0CdOXgtRTv6Bib/39rCPhcjQJEU
	 4E4g+m+Y1s54uS1yqZ333SHRpZJU4++6vKHlzpWz2+1xcTZeTbDjlFs+TfxUMNum26RLl
	 hpTPBNuju4KmYqwGna2Gzg5R4l5QMUIkmXCUlckq0VbxU09I1DKWQ9FiMbU6evUW9NnLm
	 ihTKwAHhUIcrOFDLZrAIR/XRNuUoQkDycaZHjqGS01DDSTMzbSj3fG6iPIXg0ibIhTQWK
	 r1Zi2/NHOyM275j5RkotbSblZ2uhW61ETq9wUHfyuaSlyUPar62xLJ3ZXxCmrid7xaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lzw8tJf+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A4A606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lzw8tJf+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E731F0089F;
	Sat,  7 Nov 2026 10:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047320;
	bh=AiCubS16eynK3H117nThpdlBeXj03I2/d/0BU8Ci/bk=;
	h=From:To:Cc:Subject:Date;
	b=Lzw8tJf+8jpikJhoMOQXJHf3a5ZHVk/ShrFoUt4QhUO9c1r2xR6wD24N6zoSQfAbo
	 Vmpr9qLpMHmVaoM95S5j7QMFr7whRvel3HuFS/nb32IzrKE3uv4r5HITjTkgSRT6y/
	 otiP9511goxQO6f+MHeOALU+8eVH63EHUebxEImsGkGYOr242ZDTFHwOwsPAL2EYNx
	 V+oBj0PL39ThSHR0iS0OjfPpUu62pnLi3ONCY/9Ol0NUnRAtDhGq7MPTaKyQkSJ+fF
	 UFqHu+f/kec54cxLJYor8TuqqutHtmZt+etcqtWYRdbUfYzi9ZfpelBtHZHJVltuYR
	 Zy4oGiyd8WiGw==
From: Sasha Levin <sashal@kernel.org>
To: dwmw@amazon.co.uk,
	sashiko-bot@kernel.org,
	paul@xen.org,
	pbonzini@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: x86/xen: Enforce 4-byte alignment of vcpu_info registration" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:28:38 -0500
Message-ID: <20261107052838-failed-6.6-eacdb76c5f04@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x eacdb76c5f04956035c5d7f7e1973028f30684a2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052838-failed-6.6-eacdb76c5f04@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From eacdb76c5f04956035c5d7f7e1973028f30684a2 Mon Sep 17 00:00:00 2001
From: David Woodhouse <dwmw@amazon.co.uk>
Date: Mon, 31 Aug 2026 22:26:37 +0100
Subject: [PATCH] KVM: x86/xen: Enforce 4-byte alignment of vcpu_info
 registration

Xen's map_guest_area() enforces that vcpu_info is aligned to
sizeof(xen_ulong_t). KVM has no such check, allowing a guest to
register vcpu_info at an arbitrary byte alignment.

Enforce unconditional 4-byte alignment regardless of the current
shinfo mode. This is sufficient because subsequent commits ensure
that all locked atomic operations on vcpu_info fields use at most
32-bit accesses. Return -ENXIO on failure, matching Xen's
map_guest_area() behaviour for unaligned requests.

Originally observed in review of an unrelated patch:
https://lore.kernel.org/all/20260604193554.1BA311F00893@smtp.kernel.org/

Cc: stable@vger.kernel.org
Fixes: 73e69a86347a ("KVM: x86/xen: register vcpu info")
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260604193554.1BA311F00893@smtp.kernel.org
Assisted-by: Kiro:claude-opus-4.6-1m
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
Link: https://patch.msgid.link/20260831213632.81023-7-dwmw2@infradead.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/xen.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index d0bdc6e8eb28c..15c508b7b28b7 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -941,6 +941,10 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 				break;
 			}
 
+			r = -ENXIO;
+			if (!IS_ALIGNED(data->u.gpa, sizeof(u32)))
+				break;
+
 			r = kvm_gpc_activate(&vcpu->arch.xen.vcpu_info_cache,
 					     data->u.gpa, sizeof(struct vcpu_info));
 		} else {
@@ -950,6 +954,10 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 				break;
 			}
 
+			r = -ENXIO;
+			if (!IS_ALIGNED(data->u.hva, sizeof(u32)))
+				break;
+
 			r = kvm_gpc_activate_hva(&vcpu->arch.xen.vcpu_info_cache,
 						 data->u.hva, sizeof(struct vcpu_info));
 		}
-- 
2.53.0




