Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794409080;
	b=vjVpSvGBDVqoAvZ8c2z0tKLRk2GiodYn5HDlztD2FMCXqSsKSq3jk1TJsb0g63wk0xuN
	 Et7K9FwOonmYrbIpRjWMGjqeT7/0xG3gY3i9T0NEIRD59125Un7+gc6RpZnTxmAw8F36C
	 5n9BB2S/hPUyPSOmdYFmGoGYGe4nHlFj8/rVYCjnB9bOYRCvNOBlzTN2j/VjJCPB4U6dh
	 rUHTTIhKwm0tpnkRlG/713SUOxLaHnj/sECM9jQVttIonMdhM/z00nOqZTKxFDTp1L/AU
	 SR3YZuytbzsW6uTSRcRYMy7SPT9zsJ6LUI44JbK3jbpdYf8UpoLtRlig6l1POzEgvfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409080;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=7ykvl4TfBSk/nPuLE+62lmDD8jntOs2T+Nzf9MEyT00=;
	b=2jMu3lusDCoeHBdPceSBGvp3y4hWwQjKapHymHGmUdP7ACT8HAP7jTZVDcPKFkiFYW3Y
	 Bs0rTduniT2zXOfMFPE0PoPg+doydqOL3KgjTpGiQ9I20EhRvcAUaqLkphpvX9M0IPwCO
	 UPq9DmPHjmgjf13p/VIf/CSUO/86Af5nKQ7QlcbE0jv0W4t2LluWRSag9xxyPO5qhKsTy
	 IKv4xiRiIklswb9YG1UZzsX7HVoqfD+aGmkBEb3nop9D74v7ifu6V3ItNKAl/yKF1jxS8
	 QgqzmwRjgvMYJBnKwLxnarZfb1TmL6H3gdYDo0uhuuSzwejwUqgZi/M7230Kl1ut6iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=wDBscz1H;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A394D606A327;
	Wed, 11 Nov 2026 14:57:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A394D606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=wDBscz1H
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jPmpt0sRzz4yjjF;
	Wed, 11 Nov 2026 22:57:58 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794409078;
	bh=RSyi96C+BtD/1WdNUT2fDfaAcsY630G7i3kXD0+PQ1U=;
	h=Date:From:To:Cc:Subject;
	b=wDBscz1Hn20cZ2iv5RRVsiw05ccTZPaemeILBenCloU7OrqxevmhIIgKBn9JbauFI
	 54zLKA4S1418X5q/TV7irQORpEetHMtviP2dcLzfmdgJF/Frv1FBDIBTUJpuZfo9L0
	 hs313izpM8xOmiHjOMT7oQ6aTqV6me2Na/YJpUW2emwM9fFm1+M3WUCnvVrmqkqsO8
	 UHpm95jNM6TYfQG568hWgtmIoFkTrR/eaFn0Zn+XYV0LciWK12lprA7gkt3wkZgEjg
	 qrSSPjiZ4XdJtfax7004HDWbK8f3Vv1kRrq9WElGxQ1ivajFFKYqrW+L3/qp3bRDLq
	 iPXtA29rsbgng==
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 6ABEvp9F073354;
	Wed, 11 Nov 2026 22:57:51 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 11 Nov 2026 22:57:52 +0800 (CST)
X-Zmail-TransId: 2af96af482709ba-6b89b
X-Mailer: Zmail v1.0
Message-ID: <202611112257529855AMDZLzg8ZmFDQ3fBstbi@zte.com.cn>
Date: Wed, 11 Nov 2026 22:57:52 +0800 (CST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <tom.leiming@gmail.com>, <shuah@kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDAvNF0gdWJsazogcmVwb3J0IHJlY292ZXJ5IHRlc3QgZmFpbHVyZXMgYW5kIGZpeCB0aGUgZXhwb3NlZCBkZWZlY3Rz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6ABEvp9F073354
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Wed, 11 Nov 2026 22:57:58 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF48276.000/4jPmpt0sRzz4yjjF

The four patches make the ublk recovery tests report failures from their
workers, and then fix the two defects that the stricter tests exposed.
They are one series because the later work came out of the earlier
patches: patch 2 applies on top of patch 1, and patches 3 and 4 are the
two independent fixes that patch 2's testing uncovered.

Patch 1 waits for the recorded recovery worker PIDs and reports their
status from the parent, so a failed worker no longer ends in PASS.  It is
a v2 of the patch posted separately on 11-09; the only change is the
simplified wait loop Ming Lei asked for, and his Reviewed-by is kept.

Patch 2 generalizes that collector for the stress scripts, which used a
bare wait in nine of them and could print PASS after a worker failed.

Patch 3 cancels a command that is committed after the quiesce
cancellation scan has passed its slot; without it the server waits for a
completion that never comes and the device stays LIVE.  This is the
kernel fix and carries Fixes: and Cc: stable.

Patch 4 clears the uring_cmd flag word when a selftest batch SQE is
reused, so a recycled slot no longer carries the multishot flag of the
previous batch fetch and is rejected with -EINVAL.

Tested on next-20261105 with CONFIG_BLK_DEV_UBLK=y in a local QEMU/KVM
VM (4 vCPUs, 4 GiB), with real ublk devices, kublk and fio.  Patch 1
keeps its 71-scenario stub matrix.  For patch 2, all nine stress scripts
passed before and after; with an injected ADD_DEV failure all nine
previously reported PASS with exit status 0, and now report FAIL with
255.  For patch 3, a test-only server hook held one COMMIT across a
successful quiesce: the original kernel stayed LIVE until a second
quiesce, the patched kernel reached QUIESCED directly, two runs per
version.  For patch 4, the original kublk rejected the reused batch SQE
with -EINVAL and its daemon exited, the patched kublk kept the device
LIVE.  With both fixes applied the four recovery scripts passed twice
per version.

Shao Mingyin (4):
  selftests: ublk: propagate recovery worker failures
  selftests: ublk: propagate stress worker failures
  ublk: cancel commits arriving after the quiesce scan
  selftests: ublk: clear reused batch SQE command flags

 drivers/block/ublk_drv.c                        | 40 ++++++++++++++++---------
 tools/testing/selftests/ublk/batch.c            |  1 +
 tools/testing/selftests/ublk/test_common.sh     | 30 ++++++++++++++-----
 tools/testing/selftests/ublk/test_recover_01.sh | 20 ++++++++++---
 tools/testing/selftests/ublk/test_recover_02.sh | 20 ++++++++++---
 tools/testing/selftests/ublk/test_recover_03.sh | 20 ++++++++++---
 tools/testing/selftests/ublk/test_recover_04.sh | 14 +++++++--
 tools/testing/selftests/ublk/test_stress_01.sh  |  9 ++++--
 tools/testing/selftests/ublk/test_stress_02.sh  |  9 ++++--
 tools/testing/selftests/ublk/test_stress_03.sh  | 23 +++++++++++---
 tools/testing/selftests/ublk/test_stress_04.sh  | 23 +++++++++++---
 tools/testing/selftests/ublk/test_stress_05.sh  | 28 ++++++++++++-----
 tools/testing/selftests/ublk/test_stress_06.sh  | 15 ++++++++--
 tools/testing/selftests/ublk/test_stress_07.sh  | 15 ++++++++--
 tools/testing/selftests/ublk/test_stress_08.sh  | 10 +++++--
 tools/testing/selftests/ublk/test_stress_09.sh  | 10 +++++--
 16 files changed, 221 insertions(+), 66 deletions(-)

---
base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
