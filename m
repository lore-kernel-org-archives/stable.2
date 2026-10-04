Received: from smtp-5.sys.kth.se (smtp-5.sys.kth.se [130.237.48.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B4041440D;
	Sun,  4 Oct 2026 10:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.237.48.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791109985; cv=none; b=eEPb2nBw0nbn5AYqhfQqtL/6Q9P/jglSD/sTq4lduUDTd25HAXYI7OhmkdDjD2eI+R1cC48HeHxFIhomlMRpa5QXmcchJA4qDXW8qm1I1Ik6Z/62d3xvw7zEciqBY6HiWIjphhlPNRyzFJs8gQDSGB+u0GqT2w8TI0l5zrYianQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791109985; c=relaxed/simple;
	bh=4Eg1bseuOm0LtRxG2sP30PwsV98QHQ8BWBPpbSvJvNw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=WmJReAFWpIiHvUwL83I6iPZABHxsJxkp9u03H2K3QOGhIANqhKr6XMizIs03uUWrv48Ah0JlMNoDe10kCI8X2XMwGocNlG8VS98RgdGlzYvSuSrCT3Ev0or7Nh1ozPiBgKCJMt/z4bKrKLg7mmdGyslWhDeDExmanHQslgAG7Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kth.se; spf=pass smtp.mailfrom=kth.se; dkim=pass (1024-bit key) header.d=kth.se header.i=@kth.se header.b=cL0dEVPE; arc=none smtp.client-ip=130.237.48.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kth.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kth.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kth.se header.i=@kth.se header.b="cL0dEVPE"
Received: from nargothrond (c213-100-197-198.bredband.tele2.se [213.100.197.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sfle)
	by smtp-5.sys.kth.se (Postfix) with ESMTPSA id 4hyJb62LhtzPNQ1;
	Sun,  4 Oct 2026 12:26:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-5.sys.kth.se 4hyJb62LhtzPNQ1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kth.se; s=default;
	t=1791109587; bh=02wVPk37I21ZtZA9x6DeMU8YzUrPNq+EKcHERYwt47M=;
	h=Date:From:To:Cc:Subject:From;
	b=cL0dEVPExuFTi61OEW2CXMLYPVLPBMfsHsA6o1NOauw+aPLuRNKudSMomulXktrVz
	 pmtEB3kB6ml6G6KsFJfsIy4k6+wtrSvIaY2jLv6qsN6KlezJYbxMLCOjuJFr+jBLAT
	 PRMJnmRXE5mVKzSr0jH68fIzxwPtwKsLU9Pf8JK0=
Date: Sun, 4 Oct 2026 12:26:16 +0200
From: Stefan Fleischmann <sfle@kth.se>
To: netdev@vger.kernel.org, stable@vger.kernel.org
Cc: Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi
 <pavan.chebbi@broadcom.com>, regressions@lists.linux.dev,
 edumazet@google.com
Subject: [REGRESSION] Commit 447cbe95ebb9 causes IOMMU DMA faults on
 macvlan/vlan with bnxt_en
Message-ID: <20261004122616.56714cbd@nargothrond>
Organization: KTH
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/ab.fgCEaa4Ri=.hF4uPJ1qp"

--MP_/ab.fgCEaa4Ri=.hF4uPJ1qp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I have bisected a regression introduced in kernel 6.18.51 (and 7.2.3).
The issue is still present in 6.18.55 and 7.2.9. Verified by reverting
1517d1996b52 (the equivalent of 447cbe95ebb9 in the 6.18 branch) on top
of 6.18.51 and 6.18.55.

The hardware is a Dell R640 server with Intel Xeon Silver 4210 and
Broadcom BCM57412 NetXtreme-E NIC.

The network interface is configured as an untagged interface and has a
couple of tagged VLAN interfaces configured on top. All of these are
used by LXC containers with Macvlan.

The interface comes up fine after boot, but after some time (anywhere
between 2 to 40 minutes) I see a DMA error in the kernel log (attached),
and the driver ends up tearing down the interface. It can be brought up
again after that, but it will hit a DMA error again after a while and
the interface goes down again.

I'm happy to provide more debug info if needed, or test patches.

I've already updated to the latest firmware released by Dell, the problem
persist. Here is some more info on the network device:

18:00.0 Ethernet controller [0200]: Broadcom Inc. and subsidiaries BCM57412 NetXtreme-E 10Gb RDMA Ethernet Controller [14e4:16d6] (rev 01)
	Subsystem: Broadcom Inc. and subsidiaries NetXtreme E-Series Advanced Dual-port 10Gb SFP+ Ethernet Network Daughter Card [14e4:4120]

# ethtool -i eno1np0
driver: bnxt_en
version: 7.2.9-1-generic
firmware-version: 238.1.168.0/pkg 38.11.70.00
expansion-rom-version: 
bus-info: 0000:18:00.0
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: no

Best,
Stefan

--MP_/ab.fgCEaa4Ri=.hF4uPJ1qp
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=bnxt_en-kernel-log.txt

2026-09-28T01:41:06.242437+02:00 r640-01 kernel: DMAR: DRHD: handling fault status reg 2
2026-09-28T01:41:06.242461+02:00 r640-01 kernel: DMAR: [DMA Read NO_PASID] Request device [18:00.0] fault addr 0xfc499000 [fault reason 0x06] PTE Read access is not set
2026-09-28T01:41:06.310547+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: Abandoning msg {0xb4 0x41a} len: 0 due to firmware status: 0x2000001
2026-09-28T01:41:07.088637+02:00 r640-01 kernel: kauditd_printk_skb: 488 callbacks suppressed
2026-09-28T01:41:07.321589+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: hwrm req_type 0x23 seq id 0x41b error 0xf
2026-09-28T01:41:07.330570+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: hwrm req_type 0xb4 seq id 0x41c error 0xf
2026-09-28T01:41:08.348631+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: Abandoning msg {0x23 0x41d} len: 0 due to firmware status: 0x2000001
2026-09-28T01:41:09.372623+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: Abandoning msg {0x23 0x420} len: 0 due to firmware status: 0x2000001
2026-09-28T01:41:10.396561+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: Abandoning msg {0x23 0x423} len: 0 due to firmware status: 0x2000001
2026-09-28T01:41:12.444634+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: Abandoning msg {0x23 0x429} len: 0 due to firmware status: 0x2000001
2026-09-28T01:41:13.468622+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: Abandoning msg {0x23 0x42c} len: 0 due to firmware status: 0x2000001
2026-09-28T01:41:14.492626+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: Abandoning msg {0x23 0x42f} len: 0 due to firmware status: 0x2000001
2026-09-28T01:41:15.516628+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: Abandoning msg {0x23 0x432} len: 0 due to firmware status: 0x2000001
2026-09-28T01:41:16.540617+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: Abandoning msg {0x23 0x435} len: 0 due to firmware status: 0x2000001
2026-09-28T01:41:19.612571+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: Abandoning msg {0x23 0x43d} len: 0 due to firmware status: 0x2000001
2026-09-28T01:41:20.636560+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: Abandoning msg {0x23 0x440} len: 0 due to firmware status: 0x2000001
2026-09-28T01:41:21.660627+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: Abandoning msg {0xb4 0x444} len: 0 due to firmware status: 0x2000001
2026-09-28T01:41:23.718601+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: Abandoning msg {0x23 0x447} len: 0 due to firmware status: 0x2000001
2026-09-28T01:41:26.780616+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: Abandoning msg {0x23 0x44f} len: 0 due to firmware status: 0x2000001
2026-09-28T01:41:27.092594+02:00 r640-01 kernel: kauditd_printk_skb: 222 callbacks suppressed
2026-09-28T01:41:27.804557+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: Abandoning msg {0x23 0x452} len: 0 due to firmware status: 0x2000001
2026-09-28T01:41:31.900559+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: Abandoning msg {0x23 0x45c} len: 0 due to firmware status: 0x2000001
2026-09-28T01:41:34.906960+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: NETDEV WATCHDOG: CPU: 9: transmit queue 1 timed out 6009 ms
2026-09-28T01:41:34.922831+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: [0.0]: tx{fw_ring: 0 prod: 2c5e cons: 2c50}
2026-09-28T01:41:34.922849+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: [0]: rx{fw_ring: 1 prod: 4ba7} rx_agg{fw_ring: 6 agg_prod: a6b sw_agg_prod: 26b}
2026-09-28T01:41:34.922853+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: [0]: cp{fw_ring: 0 raw_cons: a7d7}
2026-09-28T01:41:34.922854+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: [1.0]: tx{fw_ring: 1 prod: 58a1 cons: 56b2}
2026-09-28T01:41:34.922856+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: [1]: rx{fw_ring: 2 prod: 1025} rx_agg{fw_ring: 7 agg_prod: 8d0 sw_agg_prod: d0}
2026-09-28T01:41:34.922857+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: [1]: cp{fw_ring: 16 raw_cons: 42d4}
2026-09-28T01:41:34.922859+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: [2.0]: tx{fw_ring: 2 prod: 300c cons: 2fe2}
2026-09-28T01:41:34.922861+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: [2]: rx{fw_ring: 3 prod: 1152} rx_agg{fw_ring: 8 agg_prod: 8ce sw_agg_prod: ce}
2026-09-28T01:41:34.922862+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: [2]: cp{fw_ring: 17 raw_cons: 3300}
2026-09-28T01:41:34.922864+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: [3.0]: tx{fw_ring: 3 prod: 1e3c cons: 1e18}
2026-09-28T01:41:34.922865+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: [3]: rx{fw_ring: 4 prod: 23aa} rx_agg{fw_ring: 9 agg_prod: 937 sw_agg_prod: 137}
2026-09-28T01:41:34.922866+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: [3]: cp{fw_ring: 18 raw_cons: 4fe4}
2026-09-28T01:41:34.922867+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: [4.0]: tx{fw_ring: 4 prod: 1dd4 cons: 1dad}
2026-09-28T01:41:34.922869+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: [4]: rx{fw_ring: 5 prod: 1a86} rx_agg{fw_ring: 10 agg_prod: 153e sw_agg_prod: 53e}
2026-09-28T01:41:34.922870+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: [4]: cp{fw_ring: 19 raw_cons: 4a5d}
2026-09-28T01:41:34.922871+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: hwrm req_type 0x91 seq id 0x465 error 0x3
2026-09-28T01:41:34.931036+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: hwrm req_type 0x46 seq id 0x466 error 0x2
2026-09-28T01:41:34.931549+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: hwrm req_type 0x71 seq id 0x467 error 0x3
2026-09-28T01:41:34.939553+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: hwrm req_type 0x44 seq id 0x468 error 0x3
2026-09-28T01:41:34.955420+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: hwrm vnic set tpa failure rc for vnic 0: fffffff3
2026-09-28T01:41:34.963548+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: hwrm req_type 0x41 seq id 0x469 error 0x3
2026-09-28T01:41:34.982633+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: hwrm req_type 0x41 seq id 0x46b error 0x3
2026-09-28T01:41:34.982651+02:00 r640-01 kernel: workqueue: drm_fb_helper_damage_work hogged CPU for >10000us 7 times, consider switching to WQ_UNBOUND
2026-09-28T01:41:35.036321+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: Resp cmpl intr abandoning msg: 0x51 due to firmware status: 0x2000001
2026-09-28T01:41:35.045234+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: hwrm_ring_free type 1 failed. rc:fffffff0 err:3
2026-09-28T01:41:35.065242+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: hwrm_ring_free type 1 failed. rc:fffffff0 err:3
2026-09-28T01:41:35.116722+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: Resp cmpl intr abandoning msg: 0x51 due to firmware status: 0x2000001
2026-09-28T01:41:35.125713+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: hwrm_ring_free type 2 failed. rc:fffffff0 err:3
2026-09-28T01:41:35.171632+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: Resp cmpl intr abandoning msg: 0x51 due to firmware status: 0x2000001
2026-09-28T01:41:35.207067+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: Resp cmpl intr abandoning msg: 0x51 due to firmware status: 0x2000001
2026-09-28T01:41:35.207079+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: hwrm_ring_free type 2 failed. rc:fffffff0 err:3
2026-09-28T01:41:35.227564+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: hwrm_ring_free type 2 failed. rc:fffffff0 err:3
2026-09-28T01:41:35.249621+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: Resp cmpl intr abandoning msg: 0x51 due to firmware status: 0x2000001
2026-09-28T01:41:35.268237+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: hwrm_ring_free type 2 failed. rc:fffffff0 err:3
2026-09-28T01:41:35.278721+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: Resp cmpl intr abandoning msg: 0x51 due to firmware status: 0x2000001
2026-09-28T01:41:35.287205+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: hwrm_ring_free type 2 failed. rc:fffffff0 err:3
2026-09-28T01:41:35.297692+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: Resp cmpl intr abandoning msg: 0x51 due to firmware status: 0x2000001
2026-09-28T01:41:35.306162+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: hwrm_ring_free type 2 failed. rc:fffffff0 err:3
2026-09-28T01:41:35.314227+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: hwrm req_type 0x51 seq id 0x47e error 0x3
2026-09-28T01:41:35.355835+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: hwrm req_type 0x51 seq id 0x480 error 0x3
2026-09-28T01:41:35.363894+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: hwrm req_type 0x51 seq id 0x481 error 0x3
2026-09-28T01:41:35.372400+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: hwrm_ring_free type 0 failed. rc:fffffff3 err:3
2026-09-28T01:41:35.389012+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: hwrm_ring_free type 0 failed. rc:fffffff3 err:3
2026-09-28T01:41:35.397068+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: hwrm req_type 0x61 seq id 0x483 error 0x3
2026-09-28T01:41:35.415553+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: hwrm req_type 0x61 seq id 0x485 error 0x3
2026-09-28T01:41:35.423615+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: hwrm req_type 0x61 seq id 0x486 error 0x3
2026-09-28T01:41:35.423632+02:00 r640-01 kernel: workqueue: drm_fb_helper_damage_work hogged CPU for >10000us 35 times, consider switching to WQ_UNBOUND
2026-09-28T01:41:35.431702+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: hwrm req_type 0x61 seq id 0x487 error 0x3
2026-09-28T01:41:35.439788+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: hwrm req_type 0xb1 seq id 0x488 error 0x3
2026-09-28T01:41:35.447860+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: hwrm req_type 0xb1 seq id 0x489 error 0x3
2026-09-28T01:41:35.455951+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: hwrm req_type 0xb1 seq id 0x48a error 0x3
2026-09-28T01:41:35.464036+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: hwrm req_type 0xb1 seq id 0x48b error 0x3
2026-09-28T01:41:35.472127+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: hwrm req_type 0xb1 seq id 0x48c error 0x3
2026-09-28T01:41:35.502327+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: hwrm req_type 0xb0 seq id 0x48d error 0x3
2026-09-28T01:41:35.502351+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: hwrm stat ctx alloc failure rc: fffffff3
2026-09-28T01:41:35.513566+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: bnxt_init_nic err: fffffff3
2026-09-28T01:41:35.541674+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: nic open fail (rc: fffffff3)
2026-09-28T01:41:35.541691+02:00 r640-01 kernel: bnxt_en 0000:18:00.0 eno1np0: Abandoning msg {0x20 0x48e} len: 0 due to firmware status: 0x2000001
2026-09-28T01:41:37.304638+02:00 r640-01 kernel: kauditd_printk_skb: 7 callbacks suppressed


--MP_/ab.fgCEaa4Ri=.hF4uPJ1qp--
