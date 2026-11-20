Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.134.164.83
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795191800;
	b=YvcGHqqwOz2wjw3xn216pRMD6sLmOlnPoCkv7TQ92ud9P7RQceUCZrOHa8UlS6NyFC02
	 mqE2dCAhA5lQ8IG1IrWG1e73WWtU4d/69UUY3hVxnrWpSPZhFQx0y0uiJ8figMLqwk8eB
	 D0D2WsmFCy1eSgx5BaDCeBEboVQrTm/kNry8hjf7V14o1BjAx/qH44Pi5CkDT/P86qJq9
	 yCgCLGZawbmblthudqPPoKyvV2vP66Wh4+LdzyxMWjHmPp6iO+wLYguSj5SmAoE7N1bCG
	 DbBLSr37vcNfDqmcVaMPYazKKNxI3lLU2HtQdzdS8jX6Makrtry4v9DWTp+pfg5byLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795191800;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=W+TpxS1i+J9I/NKJ3cSN+tLGKZHGRM6TY2QWiTn+Pqw=;
	b=DNfaWustBveXnfQxvS7/44Y3gdifONn0CtsNADDear77rhd/bi9IzMrztGEBup/TKBsQ
	 938Y3VqJnolkUjsgYL+WnS6G3GzCyX/8MUKJTh9NlFLKGcFBf4LxEynsueCBVmzkEttp8
	 NpOfB7UUuWU3qdDg8It2+zPtVItgkrRFSWFT9drXHkQ4Q7U9DKcIGeBmKXypvLPchsJ0F
	 COAWMVJpCJ15WXu2twag2U7wJdftwQidux02BrQ2+xsTp9xMujcUFcwJJwsWxDUWvl2d0
	 UNwl0jy6uUoKAhAMlL6+t6MN23Q9JGNE0HFpDs7WNlK5Af60S2qK7GYx5b3jeR701Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=inria.fr;
	spf=pass smtp.mailfrom=inria.fr;
	dkim=pass header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=YDaM9KU6;
	arc=none smtp.remote-ip=192.134.164.83
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C71606A320;
	Fri, 20 Nov 2026 16:23:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3C71606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=YDaM9KU6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W+TpxS1i+J9I/NKJ3cSN+tLGKZHGRM6TY2QWiTn+Pqw=;
  b=YDaM9KU6/kXBvD6g49Wx5jS4NOymnKZuz69pkB3lGxpPAlej1Sy6vLUn
   JyGASBlcmBuAuIWHtbDFDY3CYOYw5UrbD6+7micLm6C/Cis51ZbGI/aXA
   e5BhfK7lwNyeBzNbJ6xAqI7uUcWX1VQK2MftcH7E2C66y7LR7/Unx+FsK
   w=;
X-CSE-ConnectionGUID: PUjWxCQKTyq/W1N/uAkTuQ==
X-CSE-MsgGUID: VcX/fQEXTbeOvkyefUMb3A==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=zakaria.belkadi@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.27,223,1787004000"; 
   d="scan'208";a="306591356"
Received: from unknown (HELO Dellisimo.rennes.centralesupelec.fr) ([192.70.40.1])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 17:23:06 +0100
From: Zakaria Belkadi <zakaria.belkadi@inria.fr>
To: Christoph Hellwig <hch@infradead.org>,
	Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	florence.schadle@ssi.gouv.fr,
	frederic.tronel@centralesupelec.fr,
	louis.rilling@irisa.fr,
	stable@vger.kernel.org
Subject: Re: [PATCH RESEND] block: pin user PI pages for writing when ref tags are remapped
Date: Fri, 20 Nov 2026 17:22:57 +0100
Message-Id: <20261120162257.498238-1-zakaria.belkadi@inria.fr>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <awBnB-55HQ54C1x6@infradead.org>
References: <awBnB-55HQ54C1x6@infradead.org>
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

Christoph, Caleb,

Thanks to both of you for the review.

On Fri, Nov 20, 2026 at 07:28:07AM -0800, Christoph Hellwig wrote:
> I don't think we can just pin memory as writable that wasn't given to
> us as writable.  So this needs to force bounce buffering, at least when
> remapping might be required.

Agreed. I'll keep the PI iterator as ITER_SOURCE. In v2,
bio_integrity_map_user() will bounce the user PI buffer for REQ_OP_WRITE
when the integrity profile has BLK_INTEGRITY_REF_TAG. That way the
block layer can remap the tags in its own copy.

Thanks,
Zakaria
