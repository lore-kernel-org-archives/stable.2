Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9FC313E03;
	Sun,  4 Oct 2026 11:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791114374; cv=none; b=CckdIcsTxVM5SJ1kqpuglTnYHvlEWd7bcl7NUdXq6qRumAB3FEm6zrCqVpJgzZyvYg9foEn2W1x1cUKiM6KEeVxELcbQRfqygEnbQo1UGsSzW4Kt9JYH3ovVh6QMoU48oCIVX1QAHLb/n+k0Z7VNDq7P6Yg2Ykm+7gpuwzU5vbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791114374; c=relaxed/simple;
	bh=BNCNvqlSdQgCGZglcBRKo95ngBtg2fwoeaiBlf8VQtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AUUROwFDWCZYPtHUZRllmVXC6V12J2zQ4K1ekGvDKUOyebifd9k5U/3K12MoBP8l344xjGRQEHAUvQuwok8ylekCTaNVP9Olh6n/LVAUIsd9nfx2lKBsf6k0eCMlcBTwbftd4fs8+YfvwFwNnE3jsO13Aw+322yXn3piLkp9Aos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvXUOYB2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvXUOYB2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB3F1F000FF;
	Sun,  4 Oct 2026 11:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791114372;
	bh=HR+Flyh6aOq+YBmyhdw6aQRstQVaH53Q+XG2o/BckCY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=QvXUOYB2TXNKa27HG2yT/mfKhjcX55Ox92w9jLAkcgxIlqqkLJCc76iMVFMgaOg9w
	 a/gFfoXfqcR71AWpEcwy/qoR5o2ORanMxbuWvSE5+nWoXfMagTLOqIaouKJSds0d1D
	 xbokGQP+TaojNSnMYBJH5YtXHMoxdHrpPm5AV1Ib3vzC8GRpC+JhiEPmQh1wpAScvD
	 vcslQC17rw7wb6FGR1H+FEvBZJNnlpsRbePwpxl6e3L5nuObPH/FNWqcEBPAq51uif
	 BSwikk6tPfnxgPYma6PBaNz4XO2Qx8uBaDoymu5y3dubJOCaEquMI0VAd8a+JYBGZm
	 MJDFPjaSitgGw==
Message-ID: <f0c52ecb-b85d-4a53-8329-a8d2fd5d72b8@kernel.org>
Date: Sun, 4 Oct 2026 13:46:08 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Commit 447cbe95ebb9 causes IOMMU DMA faults on
 macvlan/vlan with bnxt_en
To: Stefan Fleischmann <sfle@kth.se>, netdev@vger.kernel.org,
 stable@vger.kernel.org
Cc: Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, regressions@lists.linux.dev,
 Joe Damato <joe@dama.to>
References: <20261004122616.56714cbd@nargothrond>
Content-Language: en-US
From: Eric Dumazet <edumazet@kernel.org>
In-Reply-To: <20261004122616.56714cbd@nargothrond>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/4/26 12:26, Stefan Fleischmann wrote:
> Hi,
> 
> I have bisected a regression introduced in kernel 6.18.51 (and 7.2.3).
> The issue is still present in 6.18.55 and 7.2.9. Verified by reverting
> 1517d1996b52 (the equivalent of 447cbe95ebb9 in the 6.18 branch) on top
> of 6.18.51 and 6.18.55.
> 
> The hardware is a Dell R640 server with Intel Xeon Silver 4210 and
> Broadcom BCM57412 NetXtreme-E NIC.
> 
> The network interface is configured as an untagged interface and has a
> couple of tagged VLAN interfaces configured on top. All of these are
> used by LXC containers with Macvlan.
> 
> The interface comes up fine after boot, but after some time (anywhere
> between 2 to 40 minutes) I see a DMA error in the kernel log (attached),
> and the driver ends up tearing down the interface. It can be brought up
> again after that, but it will hit a DMA error again after a while and
> the interface goes down again.
> 
> I'm happy to provide more debug info if needed, or test patches.

Hi Stefan,

Thanks for the bisect and detailed report.

Notice that 0xfc499000 is on an exact 4KB page boundary. This points to 
a DMA read overrun where the Broadcom DMA engine reads past the end of a 
buffer mapped in page 0xfc498xxx into the adjacent unmapped page 0xfc499000.

Have you tried a recent net kernel ?

Could you please test whether disabling TSO or hardware VLAN offload 
prevents the crash? (maybe adding one option at a time)

   # ethtool -K eno1np0 tso off

   # ethtool -K eno1np0 tx-vlan-offload off

Adding Joe to this thread, because some parts in
tso_dma_map_init() or tso_start() might have bugs.

# Disable USO on the physical interface
ethtool -K eno1np0 tx-udp-segmentation off

This reminds me on a prior attempt I made months ago to sanitize tso_start()

Note that my email address has changed to edumazet@kernel.org

Thanks.

> 
> I've already updated to the latest firmware released by Dell, the problem
> persist. Here is some more info on the network device:
> 
> 18:00.0 Ethernet controller [0200]: Broadcom Inc. and subsidiaries BCM57412 NetXtreme-E 10Gb RDMA Ethernet Controller [14e4:16d6] (rev 01)
> 	Subsystem: Broadcom Inc. and subsidiaries NetXtreme E-Series Advanced Dual-port 10Gb SFP+ Ethernet Network Daughter Card [14e4:4120]
> 
> # ethtool -i eno1np0
> driver: bnxt_en
> version: 7.2.9-1-generic
> firmware-version: 238.1.168.0/pkg 38.11.70.00
> expansion-rom-version:
> bus-info: 0000:18:00.0
> supports-statistics: yes
> supports-test: yes
> supports-eeprom-access: yes
> supports-register-dump: yes
> supports-priv-flags: no
> 
> Best,
> Stefan

