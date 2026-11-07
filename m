Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048072;
	b=EJRLY8Ph4CuSr+u7BDC7sWZznxaGdRQzjsHxdKeECt0gOPrOG9q2tZX0BaDHftQCpQlt
	 EQUdegfy8miGQYy2VJhzE80as5A8g1bSHlXhiLwyRZE7Qh2pUW9JLl55OyS3vV2VO12Kb
	 /vLW9t3V8H6mWNVsW4Tm7v4H++VrJJ8K7EgeHCMuYikbFUVk4A9bYBqq7hrWy6WOwySkA
	 mtqMj0z+YEyKHIk26Gryep5/H55aaazkDjtIIwpcNKfFviqvTb0v82c4eLRLa8GXOdC1D
	 y08lN7gRW2tHSBqbGPg4Ku32L/ZWWwQRRdCvNdfmbO4ZDA107RaxtBDzmWCObXKwZog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048072;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Nvsa4839TkKWUA7CtpKYp/pQEc9aAk/VAevWqSa2dYc=;
	b=DKurhrV3w2QYtyFiDzxYKOraLEIHp5Lpl+U3KTT3TrMIeae4Oxy8abx7xTGx+FtN2JZT
	 PB54F8TGIsIcL63byOLIGohSyFImHy9r6si1p58s3vsmFNWroCSW2WMl6aRLbW84+ptUT
	 wvFoXMpx++iFZeNaPTnF36EyYuswYe3OAdhVnyPusRFX1f0AEBcRrTXAwlIUgJvS7qyIw
	 /issMMzb+FsudypMBNIHpSqdTuyerYNndqDh4vN64/Q0TOZh3uZIrlDKK8msNv/OcnkDK
	 QCEIkqWVlYaH9Lw1OoJ6VqpXlpiCqbnqrQsiHt+TEnLmtXw+i+VPyCJthi3+P6yT9Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OkoOF3kH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB872606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OkoOF3kH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B8791F0089F;
	Sat,  7 Nov 2026 10:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048071;
	bh=Nvsa4839TkKWUA7CtpKYp/pQEc9aAk/VAevWqSa2dYc=;
	h=From:To:Cc:Subject:Date;
	b=OkoOF3kHKgxXmP4Cpwg2e/gyo/R9uD9vyV6QTQ6kUk4fpWwwvkHKJYQUvTKk/CrVF
	 ce7NVBwHx7MYtTgzpCE6aoGmj8pWwL4y8lAJ/roqPwohuMsdCXk/vMnaHSu1iXgCUS
	 9xHaEUHMwc29yrOatX0nJL/F4RP11UYzITkNu64/6YVqA0PchFvWQEDznfoGCbQUs4
	 FFSBCbTDiSq9Qg88YRPJ7gGLM4xmicqyT+TMUt8VTt8bfGMP5YNOvgDb/7nQZwtgvO
	 OWBBLJqFEsBpO6Vmx63M+ZnNKueMGpvoGqFGI3DZk2Rqgo4ljM+VNEjFWPBZN8PEn3
	 pm5s+bgIgwmMA==
From: Sasha Levin <sashal@kernel.org>
To: dwmw@amazon.co.uk,
	sashiko-bot@kernel.org,
	paul@xen.org,
	pbonzini@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: x86/xen: Enforce 4-byte alignment of vcpu_info registration" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:41:09 -0500
Message-ID: <20261107054109-failed-6.1-eacdb76c5f04@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x eacdb76c5f04956035c5d7f7e1973028f30684a2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054109-failed-6.1-eacdb76c5f04@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




