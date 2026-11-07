Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049066;
	b=Cj55VlibnBVbTUS+gJaTw6KnedR8jAKcafH2uVL9l3kikU21q+GQlDUSD8H3AokU2ioN
	 mJezNUvrIr+8GH+qZAqgIGA6Sy+p1mj/NLJvrcrBBQWOhh3H3ys8esA/MuOLRx0d6TeSh
	 rCGjYwRS0xDv92jAriAYjCWpSn69XlAjwE4WCtmOjf40NG5wCAqHVL4tdGFtDYtSzAnGL
	 ZILACgXe5hoYOkJNh3YltEuWXFEis7bGLHKk9Syil+tnff1bqiBqjkuGIhv1vvzXU/A+Q
	 MDe9AXIRe0zBy1P0rvTJRGpkGSmVZh5p8yL0uuAz0wX+5FSM00G1FPon5KNAeNDWYlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049066;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ajFRbX3CHCgeSBd6QCzKDDk8zTL/dAdkftlR6QAH5s4=;
	b=sjAnW9uY0yywkSjPFVxylFzP0lrHh8Rtxi6TF6Pk9lGXzJisHASA48h9AZw4AnRJYJ4I
	 OqLSYrQP/93ChMmDe9FsqfyVFJ7nk9RgkNgA86ezYC+feKos2N8gxIW/ComTkLvD3Acge
	 wLyLXNev0nH+8F/NtuyD3fIh/peJgjx3aF0otWZuINlSw0JoBl24J4+Fpu79JxehUehnH
	 /JGKpOz3Ekg3A4WoCyxaK/dZJdMxXGT0RpU7xsLWv+8cOtXXM93eF1yvS/YGR9ZfTujaX
	 jme8lj03A0EPni2KGTVr6075MpT30o2J//SI1jCV12keFcALxm9pFIfp5sjWooEZt+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CZC5bZYA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B36606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CZC5bZYA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D1111F008A2;
	Sat,  7 Nov 2026 10:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049066;
	bh=ajFRbX3CHCgeSBd6QCzKDDk8zTL/dAdkftlR6QAH5s4=;
	h=From:To:Cc:Subject:Date;
	b=CZC5bZYAxmFp7YqWOmn8AzizczEyneVersLYi/01yAn+0dkcnXVQreStLTajNbI70
	 eb6Ree+YUJIXx7s1rWRkGGjbh7tKHttmAyv20FGfeMZFuJUVD3Pr3Czmcl8LEOIU97
	 TVn8oQuGsEIZXvsFX2qsHrJUTJla1UNZsTQ/08gxENVrSkJ37dEOXlRANcBBkVeUMd
	 gixEEQVgqOGRXi7ZjZ8dQMT8m5B1RraG3BiuRFDy8ZU9k66lCid8p+oXYI8x7YonCB
	 EufM9ofo5uJVJ+90yoUlp4FzfANprmC0wPKnz/TDJBjOa+XAnIuAV5CNyW26ZJC2C7
	 IyRqRCWG7IkKg==
From: Sasha Levin <sashal@kernel.org>
To: dwmw@amazon.co.uk,
	sashiko-bot@kernel.org,
	paul@xen.org,
	pbonzini@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: x86/xen: Enforce 4-byte alignment of vcpu_info registration" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 05:57:44 -0500
Message-ID: <20261107055744-failed-5.15-eacdb76c5f04@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x eacdb76c5f04956035c5d7f7e1973028f30684a2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055744-failed-5.15-eacdb76c5f04@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




