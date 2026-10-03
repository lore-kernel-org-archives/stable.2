Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0025250276
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 01:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790990552; cv=none; b=pyxg98HPlGZVO4rHsV5vGI217P2veiUyxQfUAVLM2lcQnNLA4f/f+aDmKAKVIixNob0Y+5V3/PD7PhRVoK7p21EfinYAVJJNyR7qDcYVhBmvrorgsMLTivPrRQPhmOSlLKJJJMkAQ3sznktqqwpQKefgEJ7/fnBQ0rtrnxDz7p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790990552; c=relaxed/simple;
	bh=EC2ysHutNfHyx2kEpKS3O7HmAhqBDv9DKiBIacjyDQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lDjJ7T8ukfOvrVEH1AzarvapEcY4epezLqDPRJceP1+EFP0o5qTKTA9p8HJMs6bHvbK5pTrWL+3p63BItpG+sbjIutsIOvhnUaI1jpbIuQT6gD66YgLTKWW+Umvc1nn3U/k/vijwbEWUnXPm2wQKOJ90uQCusi6D43c6zpzJRto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYThIIcX; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYThIIcX"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-33e630052ebso197229eec.0
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 18:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790990543; x=1791595343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IKt5nrCKJhUIAbepDHxZ+a2pchIMUOKa3TpjI93uFg8=;
        b=QYThIIcX8qsBLAxELPe529OnP2rut9UmRfZgVD5anGlIZh5a5VLIDfTmkkR2BWgNDe
         I5Ie/DpVr7gFShZQoTq6rSajyKE5UfDKS3F4VsBq8exoDUfZws9L4rCO7zQlQH9mAfFT
         mJwz4IcIiFenPzzIpY+rEgLU3DWxcC8zQEhJJYyYN3bQw8pFIqVEid20yhY9D/vNFqCv
         IWIZfBOW6E6wAMXd3p/kYFenTAuuwYFkzw4hKVDXkBPlZpdYPUvRmq2HBWYZJ9EtZcf9
         wYPku7+VpeUMQtMdnJ3P7u58rPXGijs6uF6W8NqWSWHCFaRPsJhdnjjezWP7a5IeOEcU
         DqjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790990543; x=1791595343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IKt5nrCKJhUIAbepDHxZ+a2pchIMUOKa3TpjI93uFg8=;
        b=Qpi9jS5rWhBe16A8TB7TOptfAeraovk35TtgRJySAh2lPvoERJqf40ixcZN2AdqprF
         QQdEKKv2aK1OGly78o6Q1w5xDhKfLM13OpianOd7qfHWJPa3E40sSYsWEjIrTgrGEfo0
         PyY6qEDYEgeiMMtZNlLtMHCBL90RixlTmrabEhu7M0LeY8caSAV0dPl/4x0QjHD8qEwY
         i3Xmgzuk14giFblfZnOYW1gpFRX6MX6qeX2gEJDCzsWGI9IsnB+trdwHVxWPDMg9GpKH
         6Ejcq0DQv9/bjP4nuKpwXYZJRugVSze3pa6KrQ2cr7YHg0uFGKn4XbRYMO3HXvOt7za/
         a6EQ==
X-Forwarded-Encrypted: i=1; AKwUvByLAAHSmQmGEeXP9o4PqDY7hgA8AWQYDma7IR9W+kK5Ib6xMkE+jUjcQfuHKbDW/PUsW0Zl1zs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJGP47SCunOrpvqN5h30N40rBMRICTtGMa0Lr0Rbeq/8xREn0ko
	4dkAbwu6AToqbSedsNFU6Zh5UQ4esgGKXsdrwp962r7t0aM+YmyWKfMK
X-Gm-Gg: AYBFou3NErx+lVC8oRFJKxGB+Oq7Pl5Q6pIsAxygRgb5gcozlsReFw+PnXYdUX/jwLZ
	TV9goYBGC4mEBGKfjsSBhw/bO/2VBpaSvU7vZZTxt3hYVkT0oNaqeA9GFM8zmcboNq4jgS/gPhX
	FVeM2L0hORoUGzpLKet1JYeXQRuibxh9kfNuznaH+L+QheQR+2kcl5KBxDCGEkpJy4rSwk2RX1p
	cp9207K35QI/8fVFofLI3Fco3TPNhvn9hCdADhvl4OLqgkOFfhB+OReEnEOVdtndLjPl8GSl+xG
	jq5Hal2Y1/+m2gZwvdP1t40B021NTHNP6A/qJWdu4M1Lja0uSCV3umpeI1le6WZfN/9H8TZ3PXd
	NKDwUAhD6cVIEzr+0bEzc3BVNp5z5gEIVqjPGSM9vjJcUGdK+ym2wBerdICnWowRuZZGt6jyx71
	jDvDLhUxQ1wqB1A3mulycfrNlRRFhhWAUdCBNrk0VIoNFol5ZobCW0/oMfzBEQIuby1GzSAugfy
	5jtEbfN4ud5Gd+tf3RmVfmjURb44vRpO4jOoFkkUMYhO8zZq/2venF41fqkVA==
X-Received: by 2002:a05:693c:88dc:20b0:351:985:e729 with SMTP id 5a478bee46e88-35109953237mr2982467eec.12.1790990542518;
        Fri, 02 Oct 2026 18:22:22 -0700 (PDT)
Received: from s1lverbox.orsomething.local (47-144-201-183.lsan.ca.frontiernet.net. [47.144.201.183])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f14fd5620sm9954916eec.21.2026.10.02.18.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 18:22:21 -0700 (PDT)
From: Jean-Paul Sergent <jpsergent@gmail.com>
To: netdev@vger.kernel.org
Cc: i.maximets@ovn.org,
	kuba@kernel.org,
	kees@kernel.org,
	stable@vger.kernel.org
Subject: [Bug Report] fortify false-positive + real overread in skb_metadata_dst_cmp (geneve, gro_cell_poll)
Date: Fri,  2 Oct 2026 18:22:21 -0700
Message-ID: <20261003005449.2675.1@jpsergent.gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

We are hitting a fortify false-positive (followed by a fatal Oops) in
skb_metadata_dst_cmp() on Cilium geneve overlay traffic, via the
gro_cells GRO path. Full trace from the serial console:

  memcmp: detected buffer overflow: 108 byte read of buffer size 96
  WARNING: CPU: 0 PID: 15 at lib/string_helpers.c:1036 __fortify_report+0x45/0x60
  Modules linked in: usbhid virtio_net virtio_scsi virtio_console psmouse uhci_hcd virtio_pci virtio_pci_legacy_dev vmgenid ehci_pci ehci_hcd virtio_pci_modern_dev ata_piix button
  CPU: 0 UID: 0 PID: 15 Comm: ksoftirqd/0 Not tainted 6.18.54-talos #1 PREEMPT(none)
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
  RIP: 0010:__fortify_report+0x45/0x60
  Call Trace:
   <TASK>
   __fortify_panic+0x9/0x10
   skb_metadata_dst_cmp+0x11b/0x120
   dev_gro_receive+0x303/0x620
   gro_receive_skb+0xc5/0x230
   gro_cell_poll+0x67/0xa0
   __napi_poll+0x2f/0x190
   net_rx_action+0x2e3/0x500
   handle_softirqs+0xe7/0x310
   run_ksoftirqd+0x26/0x50
   smpboot_thread_fn+0x167/0x250
   kthread+0x201/0x260
   ret_from_fork+0x10c/0x190
   </TASK>
  ---[ end trace 0000000000000000 ]---

The WARNING is immediately followed by a fatal Oops (kernel BUG at
lib/string_helpers.c:1043, "Oops: invalid opcode: 0000 [#1] SMP PTI"),
which takes the node down. We caught the same crash twice: once in
ksoftirqd/0 after ~11.5h of uptime, once in IRQ context (Comm:
containerd-shim, dev_gro_receive reached straight from the IP receive
path) ~14 minutes into a heavy-traffic boot, same signature both
times.

Environment: 12-node Talos v1.14.2 cluster (kernel 6.18.54-talos,
built with clang + CONFIG_FORTIFY_SOURCE) as QEMU/KVM guests
(i440FX, vmxnet3 NICs), Cilium 1.18 with geneve encapsulation and
kube-proxy replacement. Workload at crash time: sustained cross-node
overlay traffic (BitTorrent + NFS + Cilium service traffic).

skb_metadata_dst_cmp() does a single memcmp of struct ip_tunnel_info
plus options:

  memcmp(&a->u.tun_info, &b->u.tun_info,
         sizeof(a->u.tun_info) + a->u.tun_info.options_len);

Geneve carries 108 bytes of options here, but kmalloc_flex() in
metadata_dst_alloc() sets __counted_by(options_len) while options_len
is still 0 at comparison time, so the compiler's view of the tail is
96 bytes -> 108-byte read of a 96-byte view. Same disease as the
tun_dst_unclone fix 4c6d43db2a4d ("net: dst_metadata: fix
false-positive memcpy overflow in tun_dst_unclone"), on the RX/GRO
sibling path; that fix carries Fixes: 69050f8d6d07 for the same
reason.

While reading the function I believe there is also a real overread,
independent of fortify: the memcmp length uses a->options_len for
BOTH sides, so when b's metadata carries fewer options than a's, the
comparison reads past b's allocation. In the geneve/GRO case both
sides come from the same tunnel and carry equal option lengths, but
the helper is generic (any METADATA_IP_TUNNEL comparison).

A patch follows: pre-check options_len equality, compare the fixed
part, then compare options via ip_tunnel_info_opts() on both sides so
the counted_by view matches the read length - the same two-stage
shape as 4c6d43db2a4d.

NOTE: I could not build-test the fix (no kernel build environment on
the reporting host). The reproducer is the production workload itself
(sustained cross-node geneve RX under GRO): with GRO left enabled the
node panicked twice; since disabling GRO offload on the geneve device
(ethtool -K cilium_geneve gro off) as a stopgap, the same workload has
run clean - consistent with the crash living in the geneve device's
gro_cells stage.

-- 
Jean-Paul Sergent
