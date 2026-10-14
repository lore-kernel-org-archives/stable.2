Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983A7566C7B
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 18:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792001969; cv=none; b=FvHEfWOjjyRpCMHkG709MfICpPLZwf5A3qWhat/Us4Ii16TFKz0Oh4V3aZFLVTgfKoB/GiCJ2v7hJlwmZGCbDCLDMFWlGp41I1vmzTBkWyC2iz/hCsttXckdWEEXvp02eWrQZlv9k8DGp+y5/f1A0VL/ygwZocjXaPpN8uNIET4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792001969; c=relaxed/simple;
	bh=xLy4bwJA3p4oGwSxkOP7algz00ABvvlb2hL7FQ0tbXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sEBZ0uZaSVDZLFQCA6NsBV5FD051X9JZenj4E8lptBQpdEZjkBHjcl4lMySK3bA1wtTtYotkjDi47fP3MvC1wqQXeJr9GLpnvLBlDtRhTcB7+9IqkTrWRWb1RwnGyzjFqwAbF6gEisPe85fj4YFKGTesiB0JE8KtQ55w+FAtL40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=mcxCiTw4; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="mcxCiTw4"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93a40a9a01aso175553785a.0
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 11:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792001967; x=1792606767; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d7wsO3zLWdRB4GlI02kHERXU64Q1Nav35BL5ro5gRHk=;
        b=mcxCiTw4lZJIh8U/OXoB6J70gl5U4J2msmzGl7f4VpgSa4sFZb2o+FzALZjjUAC0Ng
         Dy8VvO5LTI32n46fuv1RfgQ9Zkv2rv3SFX3o/m9O7OhKnePyftas/KdC7zytsgpJh4xJ
         ci2OI8Gy0Jwz4wExAWokrjz3PXfDwTsHdAEmDHpDBmheddrni//eLjLBHY1lPVDvnh4N
         TtsKzcF/WE7VMKVA7tdwO//4VSaNqC4GTlIl/tjOBX/uOzsTbanWVGX6iSrQ3JZ/0OsZ
         495mYKhcx45g8VLDctwl3rnIkhbi2Qb3JON5fBw9wllPBl2J2XWDlmVaIgMVD1V8KsiP
         YkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792001967; x=1792606767;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d7wsO3zLWdRB4GlI02kHERXU64Q1Nav35BL5ro5gRHk=;
        b=CtWhbvCP/UxK8uqfi1hd0nRUC13pX5Sq7oKgEk4UJuC7Zd/+AusxP/d6H9DYVMdulF
         5KxoJD+u/wy4AU9WuyzRmP46swWLE7uyyCaotm8R/rncNih6LmquEJmnqtGrKb2rGDn9
         xcuFrJ4YBXUMF8ROoRJ33Xmw+LAWLl0+1aovWZC9z94/seM73T9COiRLwX58U9FvfwVg
         u/C6zd/AR2ifL7tBXwNRaLS24AUv4LYylJ9uxwmZ9+zmUmalzeSVCQaSGqko6har3aDl
         TCg70hyFcL41ogAonjMqf+ATRKzF+awgmNbWEUKfAxk777xYEZjcUGPMcgUJoJZrCTZo
         HtTQ==
X-Forwarded-Encrypted: i=1; AKwUvBzm5XEXyYispiWv/ycaXAxbvEBTp509tU2AYugnn8ta7YN75MYwN0oH4F3svrE8YXEBrKkXimc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLSlw3Yl0KRlnrVP1+Vku5kNbbdSUPEOqkxTo4NKiDtQcJUL4hD
	HS9U5m/aJpoguPKsZ0cKDEClxr+J2IMMQGvdtzLImU1tlSxihpMIZn2SOzBd6ubTvo0=
X-Gm-Gg: AYBFou253BkCbPfN2rwozQE+DMPfqN0IDcrjWrmT2kL3SVmklil8Q21VCFQ87l4ZaMr
	63P/GIbydUNPuJ8sT0EYmVfCuC0XAyqA2gOkbY54JR1oyrUMwIB3zAqeLHx+W4pL2QNzXO0LNY2
	AGPTfDLPQs3k/9fJpBMmAU9PEJSds3bamLZB6mzqqqQnM+CU5hFQHd4GMEfrHnefgBlWnanhx7T
	x3VOeSOuv1b9I0pEOUS0uYtxxfe2cy8OmByGh3vsvXN+k0zu0+qnE10/HirU9ESN4C9yaczidn2
	Jy1wm8xOKBAFuTEwfYY8Cu9YoWM7NI51Ck8bbmEmGoKeXONBJCZEpblWzfOMZs/0Jy6pdm9t6A3
	+Em7+5PYCGUSM2aX0RuGfBszrcLVkGd+iKlSe2WNHB1jVqd+NzKDqCroIZ9aJqTom/vq2qvvLoz
	Bt+532QeMz8p9AAtSGlGhFgrpsxlizNd27tb81xmsvnkytHZqxqKJen0iaF+ZvDz0h5L4jSZupn
	lCHx8Zz24eCT2w=
X-Received: by 2002:a05:620a:2728:b0:93d:23d5:32fd with SMTP id af79cd13be357-93ec1499888mr2303090585a.27.1792001967385;
        Wed, 14 Oct 2026 11:19:27 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.244])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef508205csm553393285a.35.2026.10.14.11.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 11:19:26 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Mina Almasry <almasrymina@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>,
 Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: skbuff: make skb_copy_and_csum_bits() report
 unreadable frags
Date: Wed, 14 Oct 2026 18:17:01 +0000
Message-ID: <179200182107330.2.7762063370688204320@toxicpanda.com>
In-Reply-To: <179199883858343.2.17884063473154560573@toxicpanda.com>
References: <20261013-b4-skb-segment-nosg-unreadable-v2-1-6c28d8ffa51e@toxicpanda.com>
 <20261014135154.05de968e@pumpkin>
 <179198668564919.2.10323410751655182155@toxicpanda.com>
 <20261014173042.0a74a25d@pumpkin>
 <CAEzrpqd9Pna32K8i5Ug3tP+ZiRa7-0GmyX+sn=OwbZ_3osEAsQ@mail.gmail.com>
 <179199883858343.2.17884063473154560573@toxicpanda.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, Oct 14, 2026 at 05:27:18PM +0000, Josef Bacik wrote:
> So 0 can't mean failure here without changing checksums, and v3 will
> keep the explicit error return from v2.

Scratch the v3.  With the code staying the same, all it would add is the
reproduction details from my reply to netdev-bot, and v2 still applies
cleanly to net.  So v2 is the version to take as is.

Thanks,
Josef
