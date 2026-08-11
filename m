Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A9B43BDB0
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 11:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786446193; cv=none; b=CB58FlaNCAvhjwCrEDv4ByLqH+br5l/Dt0Y4puFUAM4AvqFu3e4SLF8N2T7m7rVMPiMilcczDNMAEKhBEMcI0XlCPKZ0gc+J3OFxqzMIaEtB52vZ9QERLCrxI+Z8W5S0rUL04kYrWm/DyT97u7Dy9ChdaucGwTrlcscUCPiZSd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786446193; c=relaxed/simple;
	bh=QVQV6H7eQC+P9Fj5S2A2xhpwyUHYmZkIGJ1ed3MOd8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SoLX47qotD+EBDe/02uKyem3d8KZBp6WLeFTdTKdExdtHxQxot48Ab09qmHytWHqlR0+MjK7ypSZ38B4nclL7Y2Ib4DQ+2n7PMNWFJXBrAr9a9umtzYfGP1iS2v4ALel/Ped5Q2hq6pvat6FdRKIClSPvJTSHlpitqcuw84RzSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MhlXv9+s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MhlXv9+s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786446190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BaB8v93zYrYSTSOFIzIds34tr0Oh+2UhjpVHDmsLjaY=;
	b=MhlXv9+sgU5nBZNb//32lu0JFclkqCwpdan1yJ7aA5p8Ulqt83vGxmi3jYMcduMq5SniA9
	3VTIPVhp+l35LFEdoP3vqK7rVROMyHWCdfySUNk7NdhJtPfS4+792GCNEJo1glOHt1YsBO
	YHqrhYq8E/oWlVL+5BI45MjJwi8PHpI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-bCP5f63rPQqaxV11gRle4w-1; Tue,
 11 Aug 2026 07:03:07 -0400
X-MC-Unique: bCP5f63rPQqaxV11gRle4w-1
X-Mimecast-MFC-AGG-ID: bCP5f63rPQqaxV11gRle4w_1786446185
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 13CF01800742;
	Tue, 11 Aug 2026 11:03:05 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.134])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8AE3A195DF91;
	Tue, 11 Aug 2026 11:03:01 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: sochnev.v.74@gmail.com
Cc: lorenzo@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: airoha: npu: load the firmware without the sysfs fallback
Date: Tue, 11 Aug 2026 13:02:53 +0200
Message-ID: <20260811110253.181862-1-pabeni@redhat.com>
In-Reply-To: <20260807024125.434055-1-sochnev.v.74@gmail.com>
References: <20260807024125.434055-1-sochnev.v.74@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
--- Patch [1]: [PATCH net] net: airoha: npu: load the firmware without the sysfs fallback ---
commit 1732abc5f78412a3a794eba72e4e0fbf37cf4fa7
Author: Vitaliy Sochnev <sochnev.v.74@gmail.com>

net: airoha: npu: load the firmware without the sysfs fallback

This switches airoha_npu_load_firmware() from request_firmware() to
request_firmware_direct() so that a missing firmware file is always
reported as -ENOENT and mapped to -EPROBE_DEFER, instead of running into
the sysfs/usermode-helper fallback and returning -ETIMEDOUT after the
loading timeout.

> diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
> index b679bed952de3..ca33e615a3f09 100644
> --- a/drivers/net/ethernet/airoha/airoha_npu.c
> +++ b/drivers/net/ethernet/airoha/airoha_npu.c
> @@ -202,7 +202,7 @@ static int airoha_npu_load_firmware(struct device *dev, void __iomem *addr,
>  	const struct firmware *fw;
>  	int ret;
>  
> -	ret = request_firmware(&fw, fw_name, dev);
> +	ret = request_firmware_direct(&fw, fw_name, dev);

[Severity: Low]
[Finding: main-1-0]
[Sources: opus-5]
Does this also drop the only message that names the firmware file when it
is genuinely absent or mis-pathed?

request_firmware_direct() passes FW_OPT_NO_WARN along with
FW_OPT_NOFALLBACK_SYSFS in drivers/base/firmware_loader/main.c:

	ret = _request_firmware(firmware_p, name, device, NULL, 0, 0,
				FW_OPT_UEVENT | FW_OPT_NO_WARN |
				FW_OPT_NOFALLBACK_SYSFS);

and _request_firmware() gates the file-naming warning on that flag:

		if (ret) {
			if (!(opt_flags & FW_OPT_NO_WARN))
				dev_warn(device,
					 "Direct firmware load for %s failed with error %d\n",
					 name, ret);

Inside fw_get_filesystem_firmware() the per-path -ENOENT report is only a
dev_dbg(), so nothing at default level mentions
airoha/en7581_npu_rv32.bin any more.

The driver side does not make up for it either: airoha_npu_probe() reports
through dev_err_probe(dev, err, "failed to run npu firmware\n"), and
dev_err_probe() logs at debug level for -EPROBE_DEFER, so a permanently
missing file leaves the device unbound with no default-level diagnostic
naming the file.

With CONFIG_MODULES=y the deferred probe timeout still emits one
"deferred probe pending: ... failed to run npu firmware" from
deferred_probe_timeout_work_func(), but that message does not name the
firmware file, and with driver_deferred_probe_timeout == 0 (the default
when !MODULES, or with deferred_probe_timeout=0 on the command line) even
that is absent.

Also worth noting: the kernel-doc for request_firmware_direct() scopes it
to "optional firmwares, which aren't always present", while this firmware
is mandatory for the probe to succeed. Would it be worth mentioning the
lost warning in the changelog, given the Cc: stable tag?

[Severity: Medium]
[Finding: main-1-1]
[Sources: opus-5]
Can this permanently break systems where the NPU firmware is only
delivered through the usermode helper?

fw_run_sysfs_fallback() bails out unconditionally on the flag that
request_firmware_direct() sets, in
drivers/base/firmware_loader/fallback.c:

	if ((opt_flags & FW_OPT_NOFALLBACK_SYSFS))
		return false;

So for this driver's only firmware request the helper delivery path is
gone for every invocation, not just for the boot-before-rootfs case the
change targets. If the file is not in the filesystem,
fw_get_filesystem_firmware() returns its initial -ENOENT,
airoha_npu_load_firmware() turns that into -EPROBE_DEFER, and
airoha_npu_probe() -> airoha_npu_run_firmware() ->
airoha_npu_load_firmware() re-defers forever, since the driver has no
other firmware source.

The configuration in question is exactly the one the changelog describes,
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y or force_sysfs_fallback armed,
with a helper that answers through the sysfs loading interface.

The changelog says:

  "The fallback is compiled in and forced in both cases; the patch does
   not disable it, it only keeps the driver from falling into it."

For this driver the helper path is disabled outright, including where it
is the only way the firmware arrives. Could that trade-off be spelled out
in the changelog, since the patch carries Cc: stable?
-- 
This is an AI-generated review.

