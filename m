Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277B6432E92;
	Fri, 24 Jul 2026 10:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784890572; cv=none; b=TH+1y87dySTZ6mP689bc8RP2sMPRPF0DsAw6Iv9X97Oxa7lcTU2E1IaY+FfQM4GPSMEIAzsLaA1F0HeiS9y64+qQYE5XJwxQZ2TWGuIL/GGyXjWlpf1i+mnN75YdWvUGokxai8f/DYu6Pmj1Auk5JTpuENiImT+glV04PPXaQq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784890572; c=relaxed/simple;
	bh=I6UBfNvVZh1oVBUO9+piYuXWCJHi35QRWiVc3/oZxZ4=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=WXPyIxOZOpmsJ6hc4oQiOVnSaL++hz9BbSwH/8E67cJCeWB1xmKwu5/GR82PYkuVs+7QpPEzzTknQwAP6MHUusLu0J6CpNKLdcar3h/jBPzdLAEqayldQx1lICKZ4CG51nUOFEzZE/93WGOPTUk2EajOOyy/nl+m0VbMN/ziSUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=c+iyus1H; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="c+iyus1H"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=bOwmN0G+JNpQ4yphnI+bJsqQsa/x5LFQtpnkOCvk05Y=;
	b=c+iyus1HA8mhiix0uGbJsu0jOJyfzeha2zFSo/3E6t4a6qpP6km4Ggp3rGhpLHCASZVgLSqXT
	fi6aa6lEFS8n51DSnM9pOyyj4PsWmCs9cCc28ExQEMGjE22Hy09q7NV7Fur54+MOCmf8jHsevxk
	scxZP5q94VPPjpWEPUwWD+I=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4h64Rw5lHGzpT0h;
	Fri, 24 Jul 2026 18:46:52 +0800 (CST)
Received: from whupemo200011.china.huawei.com (unknown [7.152.185.179])
	by mail.maildlp.com (Postfix) with ESMTPS id 5EF432025F;
	Fri, 24 Jul 2026 18:56:01 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 whupemo200011.china.huawei.com (7.152.185.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 24 Jul 2026 18:56:00 +0800
Subject: Re: [PATCH] ubifs: fix out-of-bounds read in signature length check
To: Ibrahim Hashimov <security@auditcode.ai>, <richard@nod.at>
CC: <s.hauer@pengutronix.de>, <linux-mtd@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20260724074327.73582-1-security@auditcode.ai>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <9803bb99-31b9-f21c-7ca3-e4deafc667c4@huawei.com>
Date: Fri, 24 Jul 2026 18:55:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260724074327.73582-1-security@auditcode.ai>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 whupemo200011.china.huawei.com (7.152.185.179)

ÔÚ 2026/7/24 15:43, Ibrahim Hashimov Ð´µÀ:
> ubifs_sb_verify_signature() bounds the on-disk ubifs_sig_node->len field
> before handing the signature payload to verify_pkcs7_signature(), but the
> check has the wrong sign:
> 
> 	if (le32_to_cpu(signode->len) > snod->len + sizeof(struct ubifs_sig_node))
> 
> The signature bytes start sizeof(struct ubifs_sig_node) (UBIFS_SIG_NODE_SZ,
> 64 bytes) into the node, so the payload is at most
> 
> 	snod->len - sizeof(struct ubifs_sig_node)
> 
> bytes long. Adding the header size instead of subtracting it accepts a
> declared length up to 2 * UBIFS_SIG_NODE_SZ larger than the node actually
> holds -- past the end of c->sbuf, which is vmalloc(c->leb_size).
> verify_pkcs7_signature() -> pkcs7_parse_message() -> asn1_ber_decoder()
> is then handed that inflated length and reads beyond the allocation while
> walking the DER headers. The node length comes straight from the mounted
> image, so a crafted signed UBIFS image reaches this via
> ubifs_read_superblock() before the signature is cryptographically checked.
> 
> snod->len is guaranteed to be >= UBIFS_SIG_NODE_SZ by the node scanner
> (c->ranges[UBIFS_SIG_NODE].min_len == UBIFS_SIG_NODE_SZ), so the corrected
> subtraction cannot underflow. Legitimately signed images are unaffected: a
> correct superblock never declares a signature longer than the node it is
> embedded in.
> 
> Fixes: 817aa094842d ("ubifs: support offline signed images")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
> Assisted-by: AuditCode-AI:2026.07
> ---
>   fs/ubifs/auth.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> 
> diff --git a/fs/ubifs/auth.c b/fs/ubifs/auth.c
> index a4a0158f712d..1f770795ee70 100644
> --- a/fs/ubifs/auth.c
> +++ b/fs/ubifs/auth.c
> @@ -217,7 +217,7 @@ int ubifs_sb_verify_signature(struct ubifs_info *c,
> 
>   	signode = snod->node;
> 
> -	if (le32_to_cpu(signode->len) > snod->len + sizeof(struct ubifs_sig_node)) {
> +	if (le32_to_cpu(signode->len) > snod->len - sizeof(struct ubifs_sig_node)) {
>   		ubifs_err(c, "invalid signature len %d", le32_to_cpu(signode->len));
>   		err = -EINVAL;
>   		goto out_destroy;
> --
> 2.50.1 (Apple Git-155)
> .
> 

