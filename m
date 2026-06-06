Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648054071DB
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 14:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780757098; cv=none; b=MFM1YT61b3Cbrgl0cX5duU68Axwcw51iZTlaByZf5r9OqIYVB+J44Fbav9+97k+WYbcXluNhi9wI2bYhgC4Yu9gFA7I3Y7p5LwtMakYtvz/B9SIAd+qlllirqfPUaEZSc5laRwPl0/8oMB9x5I3oqCY19IV8tOJ8b45tn/EBo3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780757098; c=relaxed/simple;
	bh=y+Ou+RW/JftfJo+LY4g2rjPGS8YzJ/MKod2Duququq4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Huro0JUsqVDqiPlSyYpeKYW+kmR6JNUc29O2ZjDg1AMz1p/9wZeOML6DQRTdjYjgNdjo7e/dkl/ISEdWd6o9xGUjJ1IHs4n3o9oUB7QSWGZ1zsVMO881vmldzVYyg6Gs2Ip3K+DukqUc/WIqnA8oEWI/BdPnb63aVRDtHlUz9Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TiBoYWIX; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TiBoYWIX"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c8584e80d59so1145163a12.2
        for <stable@vger.kernel.org>; Sat, 06 Jun 2026 07:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780757097; x=1781361897; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wYTa3IP1cU4Gwp1J6lpE/7RLamYxGpI0KGLIZWeGb5M=;
        b=TiBoYWIX7twE56Ap7jBbj/ExTxlemPGs6cr4mpRURsW7xRJKeduuHmWXN3ZxdXYnXC
         SlG49wUB/XsMGJzm03hegjX1UtIn8J9Xqju+Yq4hHY2FUf6STgmu6eZQxY8Yd6ikcSm+
         fDc/tc46NxICqRxMLKZt1sp9b1lp/t8uHgTJJzEzeiOuydKYiAsE92N2yhLrw0DyI/NA
         /03diL+bpOuxiUeDg62NCb9uIOFqMd469PJ3VZsWF4t6FCXoCULXEBdeju69SJVn+RLz
         vm1YXuClERBYO5lEykhrNpmwAwL4gc8kzdjtWz3OFRrVl1GUNU8DRtk9hdKk9uA4mcGU
         zqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780757097; x=1781361897;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wYTa3IP1cU4Gwp1J6lpE/7RLamYxGpI0KGLIZWeGb5M=;
        b=M3CCPr2SQI3bdVlkcbwWb4jIFhUmu61mjm9AQgI+crOsHH7b7lcrbcNVuR7D27Hb0G
         B7K5A3DRHXP7G86vrt2uemdaQ4oRTPpoMgyajJAYJE0o14bE3umKkuiwK4xlvs20d3lv
         uN1TGqvn4RKb3lbM5U0+uRCLmD2Bmh5hgu8W7LUBaC9QHmxq/aH5NaDlV0DFHQlkpSeB
         dk5DIeWzE17x+EsmwU4lOjjp7b+LpL77DG6EV5HF4yzxt3Q2YfKMSn9jW9pfE1+DDkxk
         dCOSSnC9AQaa0ZfQ13MdF1aE/BDvsRg1xPX+SSQxnA43K1PkiBzPwz2Nivvz2iy4isBk
         SSzQ==
X-Forwarded-Encrypted: i=1; AFNElJ9KGHBsQNWsUJ4np3FbCQr2C3EwZbfqC7zoaZ7W059OAtBz+iFO4mHgbnJylgPCW8Cd29Y6r1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHwxStSu9HH0gJJkboCh/PtbxPSOtgPhD8iPvSgsjgCg4Zollr
	JCm0hNP1IFtLO0FUpLKdHJGuMw6GtmnmUUr5tVSdnqKO7XwkAye2fJ2t
X-Gm-Gg: Acq92OGFsJezvJrcdUQUGtHso9+drbYF/sGd3HsXJLVVT7esQIRtvgdndbqIkzeqRj+
	qayDet1K5/W2ltLNReWzuv+pL5dQsOGGaPP2n3xx6Wey6n6CD7bpVOSVORd9UkcpypCErK5vCwv
	2N3UNEIaqP1LPIFV3NHYKGmmoszuM5vyvCz7/lZlLVvtn26mcuEjd8EhmR6rkoKzvGUZq719Hp0
	ii4xwlq0StyBn9/S0Tfbsdc5JFKo4K8UniaIi5ZpWCDOuY2ClNi7fK6ZDBjYb+mRVgA/IlLABqG
	qW4RzcXg8ClEn+isCFmRvX/ZlIAE1cEbKzbZnagBG0eUsrj24RVC9+sAv+65mJw0WgdimjZnQpF
	L6I1Am+Geq5i5j0mf1MCFBN340mkFCvrxg7NHFiS+SyM0O/rCGTF7Ha4KRKoTwSSjvuq1F9W5jr
	60HHt35LYEu4vuVoQiiZ0Oif6XNkXz5fpuSTIJ9twVUHRXld8oItt73w==
X-Received: by 2002:a05:6a21:a38b:b0:3b4:68e3:f14f with SMTP id adf61e73a8af0-3b4cccf7fa1mr10545721637.1.1780757096535;
        Sat, 06 Jun 2026 07:44:56 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0b2ddbsm10489084a12.24.2026.06.06.07.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 07:44:55 -0700 (PDT)
Date: Sat, 6 Jun 2026 23:44:52 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: vkuznets@redhat.com, seanjc@google.com, pbonzini@redhat.com,
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
Cc: kvm@vger.kernel.org, stable@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH] KVM: x86: hyper-v: Bound the bank index in
 hv_is_vp_in_sparse_set()
Message-ID: <aiQyZIJtO-2Aj_xN@v4bel>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hv_is_vp_in_sparse_set() uses valid_bit_nr, i.e. vp_id divided by
HV_VCPUS_PER_SPARSE_BANK, as the test_bit() index into
valid_bank_mask. valid_bank_mask is a single u64 and a sparse vCPU
set holds at most HV_MAX_SPARSE_VCPU_BANKS banks, so valid_bit_nr
must be less than HV_MAX_SPARSE_VCPU_BANKS.

The caller in kvm_hv_send_ipi_to_many() passes kvm_hv_get_vpindex(),
which is below KVM_MAX_VCPUS and therefore always within that bound.
The L2 direct flush branch in kvm_hv_flush_tlb(), however, passes
hv_v->nested.vp_id, copied verbatim from the enlightened VMCS
without any bounds check, so valid_bit_nr can reach
HV_MAX_SPARSE_VCPU_BANKS or more and test_bit() then reads beyond
valid_bank_mask.

Return false before the test_bit() when valid_bit_nr is not below
HV_MAX_SPARSE_VCPU_BANKS, since such a VP cannot be present in the
set.

Cc: stable@vger.kernel.org
Fixes: c58a318f6090 ("KVM: x86: hyper-v: L2 TLB flush")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 arch/x86/kvm/hyperv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 4438ecac9a89..d8782cb7ba02 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1839,6 +1839,10 @@ static bool hv_is_vp_in_sparse_set(u32 vp_id, u64 valid_bank_mask, u64 sparse_ba
 	int valid_bit_nr = vp_id / HV_VCPUS_PER_SPARSE_BANK;
 	unsigned long sbank;
 
+	/* A bank index beyond the mask can't be set, the VP isn't in the set. */
+	if (valid_bit_nr >= HV_MAX_SPARSE_VCPU_BANKS)
+		return false;
+
 	if (!test_bit(valid_bit_nr, (unsigned long *)&valid_bank_mask))
 		return false;
 
-- 
2.43.0

