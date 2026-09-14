Received: from mail-ot1-f97.google.com (mail-ot1-f97.google.com [209.85.210.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5432475E3
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 20:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789416224; cv=none; b=Nv5bAEkFAmB1nzf516fEBfpgGyAwyz8VFWBn0xgTCCunvTD/ogC1iky+zZcV9qfE06axk9Up6K619CCV8/ibFWGdPuZk5TRrouzGH9ixD+LkPc3YTPpXzfKa1/DHAq+A8l7mTtXwC0AJsuAPe0cF1AXfaGG5TNRfajfjM4D29ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789416224; c=relaxed/simple;
	bh=iGHNNVQOC0D0YNnZ4vMitSMlVZq1IOKF4aTaBo1p2b0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EoVTugzXQQZs9KOJomtZkDu1csM9zChxxnJ5INi3iRcrXxZY7xZdex7lAuTVN5GSXPYxcOeMGPVygteTS1ehD1uGm7w2Uns8Lmi/5/yp8Zx5Qd8T7/+LnJGer1iGg3+X9KnkDAB/HeSg0ia0WCavacZD4EX3kXWA+lYeWqujdKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NmIshWD7; arc=none smtp.client-ip=209.85.210.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NmIshWD7"
Received: by mail-ot1-f97.google.com with SMTP id 46e09a7af769-80587a80992so1687706a34.0
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 13:03:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789416222; x=1790021022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P+2cvsudH7ftH8jFsjvcC49I+38SHnXJ8HERpOnIBgE=;
        b=Q7BtxWtNUj1LNgjwlCOvIQCxONwxjVFGA0pBgxk1ywgbOYO5nRmQceYwmEcP+2EJHc
         FL5iuGpo7pnn0YhWyXIRLe9L8ITf4lxiDLk0KqEHeYlH88a+d44wgzZHWOTZM6j5GmO0
         G3hLAvXSrLwLltR9JEfGR2p4Dz+gV+xh2D5CkCuS40wUhHgl8JWtsIHIACxuWoJpaSFL
         bmGI3wdNPMCYohtWOJxqC8l4NUXjbO0R5zNJzmTkkrvPxq40W8BudPenq30yd7NFbhKq
         QQsmKLqmwE2E/yJGRt+sjQXZ0msxZq0AesmYB14Au5NFlWWRjiC8diGIwhaKUWswhVpl
         tOzQ==
X-Forwarded-Encrypted: i=1; AKwUvBxuHUN5OQA6rVMOj5xD4AYmeGOO/2oODH97CGyh3T/u/4E7824GS4w8dURrlww9R/gzeT5NEnU=@vger.kernel.org
X-Gm-Message-State: AFuF++mOgabJGQq6JfbqW/9vL4zii9EEe8vfYFCXl+Atcv5AKedSt8YN
	DxI5AYkRp/sMTY2CnWFNyuY85nzMzbIymQSrdzpxnyNZCQB620RJ+BdBHYRwPNWHeiln9rdSdsM
	i1LQD4QpbKpjV+s6KtPlL3PBi4ALdsBP4PIDCUXhD9oH0wfmlzcVM4aBZZpMGheiDhR6fzEdbjg
	xv3q8TtTfyBquwcFrwntvDlBdKS6E+AdlyRtsXD/fGcK57FqX4HKpmnJyLEPud39aJo3yUEFPIj
	Nflu/Sm7FV8eU5r2g==
X-Gm-Gg: AYBFou1STQvJ2D/D3DEdUnfXI5XtHjpcquiPlwkIFkqn8Z2jxT6t4/9d2/qTV87C9fM
	HuC0J8qbmUbkV+cpKiNjNGw7YPiRFakkfRj9b0L56DvkUrR2BPyznM8yguDF0tSbIBrex7oE83/
	UBpGISdJAVttZPF8ovu5kOLYtFcAE7gJNKxpctaBdHembVQxYiw2lVsxL24M7eoVQSJLl9VY0cJ
	3gaDcZ55IBwLAQqzdMwIBqfHLtK/DsmJtaq6iNxuF0wVzTx7RjPBrhg4hZv2HgbwzcrxOx4KjdY
	5gX9ro/89zqf3Uw7Lv6160a8UaFgpXUuQmxxuptWiCt66zpj3Ti/9OYeK+eSKT1TfykIrmDeHIQ
	Bw3gDXxy04Szrve4Vi/0ulorGQcBQIZ686eOXZq2v5h9jGeDV93bxDbeWGfYUZ/A6R3S4aCrqoa
	b3otgS4RBNgzMCN4fcjuhmy+zjDd3m4lM7iMBa24nL5g==
X-Received: by 2002:a05:6830:82fc:b0:7e6:f2dd:93c3 with SMTP id 46e09a7af769-8089926763dmr2704735a34.15.1789416221649;
        Mon, 14 Sep 2026 13:03:41 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-806850da62dsm3700706a34.7.2026.09.14.13.03.41
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Sep 2026 13:03:41 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91049eac948so59376186d6.1
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 13:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789416221; x=1790021021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P+2cvsudH7ftH8jFsjvcC49I+38SHnXJ8HERpOnIBgE=;
        b=NmIshWD7q+L/mPmx/iBb5DNwEM+i1HSjempw8DL9+fg70BlHVPoLUkOS9M9Q4b+a2e
         qHOkbPuj8x9zjqLDyuWus5TSEiKtPeJUsDz3IjCZdpxx+Ay7fND1EqOpR4HAec2Q/seh
         HjLcG3gwMyYKvhy/BST9rqJ6gMH18wy2GQMcE=
X-Forwarded-Encrypted: i=1; AKwUvByTrxGCFrkTemqSuBSzWkSHK/xhcdWLh3NolXXBQD5UZW9cIDLhw/HqN7KAcOZbFL9byMaSLBM=@vger.kernel.org
X-Received: by 2002:ad4:4ea8:0:b0:910:4da6:8354 with SMTP id 6a1803df08f44-9122e55cf24mr59329366d6.17.1789416220686;
        Mon, 14 Sep 2026 13:03:40 -0700 (PDT)
X-Received: by 2002:ad4:4ea8:0:b0:910:4da6:8354 with SMTP id 6a1803df08f44-9122e55cf24mr59328966d6.17.1789416220205;
        Mon, 14 Sep 2026 13:03:40 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f477d42sm103209166d6.18.2026.09.14.13.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 13:03:39 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] wifi: brcmfmac: bound NVRAM comment parsing
Date: Mon, 14 Sep 2026 22:03:36 +0200
Message-ID: <20260914200336.1742565-1-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260830135328.12321-1-pengpeng@iscas.ac.cn>
References: <20260830135328.12321-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Sun, 30 Aug 2026 21:53:28 +0800, Pengpeng Hou wrote:
> The NVRAM parser tracks a length-bounded firmware blob but its comment
> handler uses unbounded strchr() calls. A comment without a newline or NUL
> inside the remaining blob can make the search read beyond the current
> input.
> 
> Store the bounded input length and use memchr() for comment terminators.

Please add:
Cc: stable@vger.kernel.org

> Fixes: 3e99b08ab53c ("brcmfmac: enhance nvram processing")
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

[...]

> @@ -215,6 +220,7 @@ static int brcmf_init_nvram_parser(struct nvram_parser *nvp,
>  		size = BRCMF_FW_MAX_NVRAM_SIZE;
>  	else
>  		size = data_len;
> +	nvp->data_len = size;
>  	/* Add space for properties we may add */
>  	size += strlen(BRCMF_FW_DEFAULT_BOARDREV) + 1;
>  	size += BRCMF_FW_MACADDR_LEN + 1;

size is capped at BRCMF_FW_MAX_NVRAM_SIZE to allocate the output buffer,
as some NVRAM files can be larger than 64KB due to comments. Setting
nvp->data_len to size will prematurely truncate parsing of those files.
This should be:

	nvp->data_len = data_len;

Regards,
Arend
