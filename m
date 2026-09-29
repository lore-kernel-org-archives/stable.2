Received: from sender5-pp-o94.zoho.com (sender5-pp-o94.zoho.com [165.173.182.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8D8380FEB;
	Tue, 29 Sep 2026 02:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790650654; cv=pass; b=G/jgMmULpTNAM7DnzlZ4S1r8T3LwNWXsFkst8JeF2sPd0nCnJ1CjnnH+rOnB3H6T45fPw3fNNdfCP6/sqBHLYePImNdAJbgdcFK61rMuAlpZ1QNyItEGSnqTfcbj7ZF9aQfulg4jqdAfvZp5bmirVbEmz4Rq0EEHdLo+6386PxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790650654; c=relaxed/simple;
	bh=gthnTCZn7lQRPpm1JP9ZTiF2fRRRXGhAHBkhg4McISw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P6fvqr6+oKdx9MM9MZxwfAbIIu4v/TtO8ZYN4DlJrUa+jJkr+Eqz4JXr+S8jGYRokmO9T7ybI7WyCsMSA8/R7tQ3dzKQC8UvT6GNSe7w6eQJTM+IE/r/WLVd+jqdJMcOlcbfaoPYUrLYflwI1gAlNmZ8wuw8U/QUJmTQg/ZlAWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=b9/HsS/C; arc=pass smtp.client-ip=165.173.182.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="b9/HsS/C"
ARC-Seal: i=1; a=rsa-sha256; t=1790650640; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=i6GEiY1FQSwNkSqvjyfkDWXi6rD1Z9lF57+5YOKbVz4yvbXAq42zOUFqDKSxv+y6JEyqzyjCJxot9EhVOKaFcDkRZWCLnLM50TxVGpkIigfbfz89YXZIUQQOsbbJoBREQhHLHsnthw2Qcp6BkGLIi8366CGO+oZLqo+cu7SGbeo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1790650640; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=K0H+YNFzLhdBGo+WsB4bHIjTw6BAIb/SnP2glR/raL4=; 
	b=I9a8VvbbZD2gKWaNzPed2YyWI1OLdPII3cZcse7YoZUuE+pq3s16iRxFSEDMn6wBDaP/GZQ41ejho2fYlFWbp4x2jif9F4jD2ncxEf5NhqbGU6ESoNt+KSq99wry3ohwIo60+t7C/bTmntSh7GbcTbp4yZk02zhPmWfx5lTPX2E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790650640;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=K0H+YNFzLhdBGo+WsB4bHIjTw6BAIb/SnP2glR/raL4=;
	b=b9/HsS/C9V5CSIgtIxrSzS83YbyGzX1zNyWJK6K+cdUdxHV6L8kUkVvpTh9W4S8m
	WgsqW3V6cEhih3DVeRgod2bEggPghntc6OmMM/EmjqK2S8EfleefbRR8TTW4euopNQt
	tiJeHULLJXySJO4PtjKENhiUGVLDaeRmqLopXWL8=
Received: by smtp.zohomail.com with SMTPS id 1790650638715458.39052034880126;
	Mon, 28 Sep 2026 19:57:18 -0700 (PDT)
Message-ID: <1ffc31f8-d8a7-428c-88d2-d538749a4720@zohomail.com>
Date: Tue, 29 Sep 2026 10:57:13 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] cxl/port: Clear cached dport pointers when a dport
 is removed
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jic23@kernel.org, alison.schofield@intel.com,
 icheng@nvidia.com, stable@vger.kernel.org,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
References: <20260928230341.2315153-1-dave.jiang@intel.com>
 <20260928230341.2315153-2-dave.jiang@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20260928230341.2315153-2-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu0801122736d9afa427c753647ca05a4a0000da7ec1b151de89eb794e18baad3ca7d1ba76906684d24ef7de:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/9/29 07:03, Dave Jiang 写道:
> Switch decoders cache dport pointers in cxlsd->target[], and nothing
> clears them when a dport is freed. Readers then dereference freed memory.
>
> KASAN caught it under a cxl_test load/unload loop with concurrent sysfs
> reads (abbreviated).
>
> Clear the matching slots from cxl_dport_remove(), walking the port's
> decoders the way cxl_port_update_decoder_targets() does on the add side.
> Scan all nr_targets slots, the target[] allocation size, and clear every
> hit.
>
> Fixes: 8330671c57c7 ("cxl: Add helper to delete dport")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Assisted-by: LLM
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>

> ---
> Found by KASAN while stress-testing a separate dport locking fix, not from a
> failure report.
>
> Reproducer: cxl_test, CONFIG_KASAN=y, 12 concurrent readers cat'ing
> /sys/bus/cxl/devices/*/target_list while cxl_test is unloaded and reloaded.
>
> With the fix reverted the UAF lands ~1s into the first unload, on the trace
> above. With it applied, 36 cycles across two runs are clean: no KASAN
> report, no WARNING, lockdep never self-disables. clear_decoder_target()
> fired 2916 times during those runs, so the new path ran under the load.
>
> KASAN only reports once per boot unless kasan_multi_shot is set
> (report_enabled(), mm/kasan/report.c), so the reverted-fix run cannot show
> a per-cycle count - one report is the ceiling, not the frequency.
>
> target_list output is unaffected. Clearing a slot truncates the list at the
> first NULL, so that was the regression to watch for: 88 target_list files,
> no empty values before or after, and the multiset of values is unchanged
> once the ida-assigned decoder names are stripped.
>
> Enumeration is unchanged too: 15 memdev, 12 port, 15 endpoint, 192 decoder.
> ---
>   drivers/cxl/core/port.c | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
>
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 625e4aa427db..6ff3353865e3 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1089,11 +1089,40 @@ static void cond_cxl_root_unlock(struct cxl_port *port)
>   		device_unlock(&port->dev);
>   }
>   
> +static int clear_decoder_target(struct device *dev, void *data)
> +{
> +	struct cxl_dport *dport = data;
> +	struct cxl_switch_decoder *cxlsd;
> +
> +	if (!is_switch_decoder(dev))
> +		return 0;
> +
> +	cxlsd = to_cxl_switch_decoder(dev);
> +	guard(rwsem_write)(&cxl_rwsem.region);
> +
> +	/*
> +	 * A dport can occupy more than one position of an interleave, so
> +	 * scan the whole target list rather than stopping at the first hit.
> +	 */
> +	for (int i = 0; i < cxlsd->nr_targets; i++) {
> +		if (cxlsd->target[i] != dport)
> +			continue;
> +		cxlsd->target[i] = NULL;
> +		dev_dbg(dev, "dport%d removed from target list, index %d\n",
> +			dport->port_id, i);
> +	}
> +
> +	return 0;
> +}
> +
>   static void cxl_dport_remove(void *data)
>   {
>   	struct cxl_dport *dport = data;
>   	struct cxl_port *port = dport->port;
>   
> +	/* counterpart of cxl_port_update_decoder_targets() */
> +	device_for_each_child(&port->dev, dport, clear_decoder_target);
> +
>   	port->nr_dports--;
>   	xa_erase(&port->dports, (unsigned long) dport->dport_dev);
>   	put_device(dport->dport_dev);
