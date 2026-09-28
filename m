Received: from mail-oa2-f34.google.com (mail-oa2-f34.google.com [74.125.231.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA754BF927
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 13:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790603066; cv=none; b=OO3VCGJsBnQOGhJibAE3O4D9zBxe2dZ7BnD5smTxnyVuut7YCB/jlFHtenjlPt+PRryw3JkAnLgs7tI4UAMYBn+CCHYWJAVL6JLAooMwI14EOzpUxcdfKYaw0KQVCZ6E6+nFsKWQE9VPVbcKS8ptrIdNHGAFcmpgRMAcq/zTTNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790603066; c=relaxed/simple;
	bh=GovrrZN3cHyF7Si62BejyKGqmJUiVqEeTzDNhyu+l7I=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=DnTygNV0mnKu6DdIyF5RmK5g/pE2XHQOsA/OjDajMqiWDpwX80xwiXSf/uxR2nk1xUlGkqEM+gIKtqZ1O7RMNStzjtXizog4/JqAdK6GxXLkcvqWTMzkaLAgj7jS0QJ3+h7zhDH50aQEFDYFIuwnSYtkZX5h/FcTRbRfkdUv5z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WvU2ugHT; arc=none smtp.client-ip=74.125.231.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WvU2ugHT"
Received: by mail-oa2-f34.google.com with SMTP id 586e51a60fabf-49499f845edso483023fac.0
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 06:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790603064; x=1791207864; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=OqSWB16/v2nKqaGPKDp/hMATqYQmRiJplxi26oO8Rsc=;
        b=WvU2ugHTp3bXSWN1w38L07qAdmskWfrQ66XXSVwudEVXPdXSVdAVwZojV1dY8LY1LH
         C6foY3GV3trNIhOlX4eF0GKlB7uqg+P6CH2Wn7gXs9MMAa5BeBzFVNAZyxaDDPPOfFRc
         r3vhm4vVunmcp+J8kOOmEWc2JFAWiZ6iy2Bv80K0ZAlXf+n8dZLOuWX1NKY/QtwBfIFe
         IzPUIx+p4a0gHfcJB3SocHqGYaiS+nT1bqO1mLtxsNEmjkRSppjXk7Inqm5AQGVD3/XT
         RR/zf537c/2+wk9n6HvlRVyj7iyixzBv2CsGhFZcbfs04HEMaUnzODUA0WaxFkhkua6A
         GnXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790603064; x=1791207864;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OqSWB16/v2nKqaGPKDp/hMATqYQmRiJplxi26oO8Rsc=;
        b=RqKemrBsdllCBK+A8EV36rCoxKhWslovEkoxnSHraI+HM80ktqgO9w5FlQ+Drv30NX
         LHe08zy6/RS74Z7jjEWlFPz5mUe7EqpYffX96Ajo3Sgkz+MwggoQ2CL0Iw0V9s3pQ2Yf
         SOJ4YgzIVkz2TsVYvOY5ghR6NQ5iDtbZUGjVyCBN2Z9N98qJVTUMMCigNKCt8UxVudQ2
         9DXVIBIVSBr3TFbj1PZasRW+3sbja8RPj7rm+5tOHU1+DljZVDDE8wX4vWSV/EbSvIPJ
         efVr5Gvdxtszoi7S1qugrJ2zKjDvG/HljulPWBcTToHYNZwqg9HsxCC9vgU00cErCErV
         yoBg==
X-Forwarded-Encrypted: i=1; AKwUvBys3AXstKxDJ/Jd950WEjz5Ez52gmmTqbXss8Oyc2sJFuFQtjIEKndVzij2mKAbgvoh5eEEvTA=@vger.kernel.org
X-Gm-Message-State: AFuF++k03T5tPidkkKOgyZZjFWd3TQ6kVg1EPFJr44NaSw9mjcyDlu9h
	MiKQe/m/9OwqZhv1BE4dumLWeNoQbE531ZRvCoiYJZWVqS1/VadTEEvL
X-Gm-Gg: AYBFou3x2PAvjxWCfTd67JVHYRsgLpliVmxdKGTyB3DN8UwSDwPpp0XAX5/6kjiVhQL
	9logEHh8nevD5ZluUaogLBllhSE+7UvOJsgiTRzSJcYobI01IBZV9rnekrEL5JO9uL2yoqzPJiK
	EYoWEaInfo/e/lWQXCaWF1PxC4iFLgShmdlbO+o4D5KiIYnVrvYx+G0IPVSiQYnTLvhdgrXpdPL
	gugjTOG08gScZn8vuqpXi36mdUT/LK//+ODtfKm+12jsIk5wPnqwku/08hN4IdWjVBbTWlPFXoZ
	eaNVHNY4LYVzNl4JClPCwu0UxW67rH+k5uCSP3BN+mkz2axLbsLZ6/xcnWBi2ftcrYnoFEjWzFv
	8XUS0/9gaesnIoPi4ZsFEbZFB6oZy8KWW6DFqkSYEOv4HS2xAtExRg64toOUfDYg85ZpRHfo3uD
	ZIFasnUCV0DVljAH9t6ejcWBwpC3eHmuiJP/IS7FcghoNNTV5QBEm4ZUxdfYPysHCHL0l6wEW77
	ByoWunCCsHVJc6bsM9JgGvFau4JeG26wlIVxh7oJERTEvpcc7GsDw==
X-Received: by 2002:a05:6871:eb03:b0:48f:e0f6:c46a with SMTP id 586e51a60fabf-49358a317cfmr9008681fac.56.1790603062123;
        Mon, 28 Sep 2026 06:44:22 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-493356565b6sm10053356fac.9.2026.09.28.06.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 06:44:21 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, R Nageswara Sastry <rnsastry@linux.ibm.com>, Alexander Graf <agraf@suse.de>, linux-hardening@vger.kernel.org, stable@vger.kernel.org, Avi Kivity <avi@redhat.com>
Subject: Re: [RESEND PATCH 2/3] KVM: PPC: Book3S HV: Add preempt_disable() around virtual-mode HPTE bit-lock users
In-Reply-To: <20260928122837.8782-3-amachhiw@linux.ibm.com>
Date: Mon, 28 Sep 2026 19:12:53 +0530
Message-ID: <tsn9jxuq.ritesh.list@gmail.com>
References: <20260928122837.8782-1-amachhiw@linux.ibm.com> <20260928122837.8782-3-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Amit Machhiwal <amachhiw@linux.ibm.com> writes:

> kvmppc_hv_find_lock_hpte() requires virtual-mode callers to run with
> preemption disabled, because it can return with HPTE_V_HVLOCK still held
> until the caller later unlocks the HPTE.  Existing virtual-mode callers
> in book3s_64_mmu_hv.c already follow that rule.
>

That make sense. LGTM. Please feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

