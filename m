Received: from sender5-pp-o94.zoho.com (sender5-pp-o94.zoho.com [165.173.182.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B337437846;
	Thu, 15 Oct 2026 09:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792056147; cv=pass; b=OnluUsCQ7aSw4RlHsR9dWnQVqyTMHi57xZa2P6hmoXIBQOvaKnz5lKGIA7bAFFMij10K66lr7LwLqlE/VQagGi3Sr8WuHhKqAhm95KyjraXq1yrtwAC/BBKXyFIY9ZSH8O58WEORcb5ToC0601nWD1BTkVsQFJUAi2ySqWek0so=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792056147; c=relaxed/simple;
	bh=wlrDeNhi0vFeVdi12dOfbDBV3U/VLtJEdpcbdhrtHok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a1EQ3vDkFx3Oc5fV9fG76gG5/t1TQtbwqRalW5IGDxYBd6idXRnFg0EgQTn9fLtLZCQdAcEkVggB8JEPPSN3WhIKKA9PJRIzt2qUBQa3Hkyegvru1nTl0bWccFTk1Q+SvNIyUnN8EvCvSgQ8UUU/mQtxNAEh1D7BhTV33igXiso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=CpQbEtVQ; arc=pass smtp.client-ip=165.173.182.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="CpQbEtVQ"
ARC-Seal: i=1; a=rsa-sha256; t=1792056127; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Q4QqAew0Ha8ZShCyQ6qFSzW9ii1fTNHTCIVot7qJCOt3HsxvyeZMwn+2Hi/2NiPipUa5kQy/NeC0Io7DBzpM6T0dG6cVWApp1lFxuz0Q36lqJQOEJUYE21JGumfAcN+9WyB3CWlW0GR0ie6ndcBMssirHkpRJGxWNlh6c0IlvGs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792056127; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=srCgxUWM4ERZ6oj9k8OUkkkSuMRRknqnY4k2BCw2XII=; 
	b=g7fCtlTA9da9TvT5PtHymaoG4WldP7oiHzJ5xuFpng62ByLNccDCRmMKxGkvkZsxj+aRrET7nvGMcuBdMV50S5wZryOvkj3f8bGuC4Q34ES/4g5xIXPj3dTNXFNsefKZmC5S7fil0GTYxsdpf6pZuVvBtcht/0o6HesMYBHdSBE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792056127;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=srCgxUWM4ERZ6oj9k8OUkkkSuMRRknqnY4k2BCw2XII=;
	b=CpQbEtVQ1HLKZSb5Sy2xjxT0QCcatCypUc2LbYjVeBygjsd1oRLuL4LipwS1X50p
	sY8m1rGIYxfnfuhkuVawirNhny5UvpT9/D2YPmPCcO+A1vVET+WZVOHHbbgAOb0wCij
	Q34DZPGPLN/7VvKA9Mh/nL0bqb555fvKGu6Z8xf4=
Received: by smtp.zohomail.com with SMTPS id 1792056125698218.4650697356194;
	Thu, 15 Oct 2026 02:22:05 -0700 (PDT)
Message-ID: <4bcc00ea-1586-471e-a51e-01a0d3f762df@zohomail.com>
Date: Thu, 15 Oct 2026 17:22:02 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] cxl/mbox: Treat unknown device return codes as errors
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <iweiny@kernel.org>, Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org, Gaobin Huang <huanggaobin23@semi.ac.cn>,
 stable@vger.kernel.org
References: <cover.1791949910.git.alison.schofield@intel.com>
 <3ed8f5db3f21c937d8783f31ee6faca3703ba72a.1791949910.git.alison.schofield@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <3ed8f5db3f21c937d8783f31ee6faca3703ba72a.1791949910.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu080112277fa1f040bc7048f62a6685ee00005c080c57e3ef53ccd94f241959d571533ecdfb5ab53ddbe6de:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/10/14 12:17, Alison Schofield 写道:
> From: Gaobin Huang <huanggaobin23@semi.ac.cn>
>
> cxl_mbox_cmd_rc2errno() and cxl_mbox_cmd_rc2str() use the device's 16-bit
> return code to index cxl_mbox_cmd_rctable[]. A return code outside the
> table's range causes an out-of-bounds read, potentially allowing a failed
> command to be reported as successful.
>
> Check the return code against the table size. Report unknown codes as
> -ENXIO, the errno used for most device-reported errors, and describe them
> as "unknown return code".
>
> Found with a QEMU Type-3 device returning codes 001Fh and 0020h, which are defined in CXL 4.0 but not yet recognized by Linux [1].
>
> [1] https://lore.kernel.org/linux-cxl/20260929060747.3550005-1-huanggaobin23@semi.ac.cn/
>
> Fixes: 92fcc1abab09 ("cxl/mbox: Improve handling of mbox_cmd hw return codes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gaobin Huang <huanggaobin23@semi.ac.cn>
> Co-developed-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>


The issue is not related this patch, but I found it during reviewing 
this patchset.

I noticed that the default errno of CXL_MBOX_CMD_RC_BACKGROUND is 
-ENXIO, but description is "background cmd started successfully", I 
checked no any driver code checks/uses this CXL_MBOX_CMD_RC_BACKGROUND's 
errno, maybe we should set to 0 like CXL_MBOX_CMD_RC_SUCCESS?

> ---
>
> This patch is independently applicable and backportable. It is
> intentionally introduced here as a lead in to the kunit patch
> that backstops this fix.
>
>
>   drivers/cxl/cxlmem.h | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index c401e3a1af06..357d0d873e87 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -6,6 +6,7 @@
>   #include <linux/pci.h>
>   #include <linux/cdev.h>
>   #include <linux/uuid.h>
> +#include <linux/array_size.h>
>   #include <linux/node.h>
>   #include <cxl/event.h>
>   #include <cxl/mailbox.h>
> @@ -205,13 +206,18 @@ static const
>   struct cxl_mbox_cmd_rc cxl_mbox_cmd_rctable[] ={ CMD_CMD_RC_TABLE };
>   #undef C
>   
> +/* The return code comes from the device and may be one this table lacks */
>   static inline const char *cxl_mbox_cmd_rc2str(struct cxl_mbox_cmd *mbox_cmd)
>   {
> +	if (mbox_cmd->return_code >= ARRAY_SIZE(cxl_mbox_cmd_rctable))
> +		return "unknown return code";
>   	return cxl_mbox_cmd_rctable[mbox_cmd->return_code].desc;
>   }
>   
>   static inline int cxl_mbox_cmd_rc2errno(struct cxl_mbox_cmd *mbox_cmd)
>   {
> +	if (mbox_cmd->return_code >= ARRAY_SIZE(cxl_mbox_cmd_rctable))
> +		return -ENXIO;
>   	return cxl_mbox_cmd_rctable[mbox_cmd->return_code].err;
>   }
>   
