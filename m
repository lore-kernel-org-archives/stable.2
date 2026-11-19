Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=18.9.28.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795099711;
	b=fLokQTKPT76iWaTNf76e+sygKfYEjaGH8KHXgz6iaAo6N0jLvyCajkhtcaPl1grPnFIb
	 uxQFp6ZqyGcRQfQoJcSjUZNggTCyFHgUGcbD8KT26ZKstDwyVG6l7IZ/e+FaMvgEvWVdB
	 1rGVS5qL1j+B+/CyAZ7tw9t99+NQU6VyCjTJbgKM/nJezwvf+DSzimYYDZ5lzHYTstqeu
	 ba8w4OHqkMKIRJ8xX94X+HVdUwRr5XuOQtkjRx7Z+0nrtiCh1R9whDUCipFUps3jbI01b
	 wIIbKpNdU/S85Xx+7897OZRLZ2ntoAiBCo4rsCIYDBmw1Z1OxIKl4Wel4y1LC+dfs/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795099711;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=po+thSK/7EuCP3cIF4sMBnblW/trAVgNir0jZ4rQz8s=;
	b=zTJOcfifiEo8VcJmlMaEL4PVQpRwu4/IJ0hO9JAVvwaCzFMQWdfd+g9WCweXksF7plSk
	 CroXIwmMGfMJ0GfxQEi959rxL9luLyTMMfGt3PmOOvT3I7I+tupt5lJjqukMnBFj/jpqS
	 ge549gHlzXvQpNT/veHCuE/dC5ALgsx9n3n8wif0NZGOaD4qtqXesuVCou8It+chDoCVa
	 Hux7UWr5hjbEKu8Gx/SF8Be3EFnCG5p/MX5XkEEgbl7st/gEcS95NZco/4cPVdWP1V802
	 /zvyGZdIvDfkl4Dvbg+whVES701Aw4MX6Gevy0EJApavFFLpNZUzQJulDht6C1QPcKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mit.edu;
	spf=pass smtp.mailfrom=mit.edu;
	dkim=pass header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b=V7Fj7H3s;
	arc=none smtp.remote-ip=18.9.28.11
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6F560A5BC1
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 14:48:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A6F560A5BC1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b=V7Fj7H3s
Received: from trampoline.thunk.org (pool-173-48-114-214.bstnma.fios.verizon.net [173.48.114.214])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 6AJElWEK017784
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 09:47:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1795099656; bh=po+thSK/7EuCP3cIF4sMBnblW/trAVgNir0jZ4rQz8s=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=V7Fj7H3shqWTPF1KLUZA2uKtwkJRBubXS4NRb7XycdtC1XU39T1qvBC6H1rfcQ6VY
	 dCTjMIV+LTTD+Vid61cWXe8WziDhtBKcbskqv7WzHAistcSZbpsTCDI7bF+6P/BydE
	 TPKPCaSQBvBVqrNJK1GuCutWBec16LojrqqItOVTDfhf7FQ/6JErrpsK8vtwN0aZrD
	 gNk2mNN9IMBRDpVHSbjzvdNNna/PYPbJoyUItROV+vQ1k23c/v1+RcjrXCwrXXi8Ht
	 y1TZnbwbJJsHy/4U0on/g2fvS3J4sCaz9TTgx1Vd+Zs2wPoJ43vGf3I4lonTg9xaEj
	 UosxkIA2x4iyg==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id B47802E013B; Thu, 19 Nov 2026 09:47:32 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ext4 Developers List <linux-ext4@vger.kernel.org>, lty <781735889@qq.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        libaokun@linux.alibaba.com, jack@suse.cz, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, yi.zhang@huawei.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ext4: propagate errors from fast commit bitmap rebuild
Date: Thu, 19 Nov 2026 09:46:32 -0500
Message-ID: <179509948676.1938961.9554359615132836257.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <tencent_B320F7091730E06C02BAB57D87B0CE363107@qq.com>
References: <tencent_B320F7091730E06C02BAB57D87B0CE363107@qq.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 15 Sep 2026 18:29:22 +0800, lty wrote:
> ext4_fc_set_bitmaps_and_counters() rebuilds block bitmaps for modified
> inodes during fast-commit replay. When ext4_map_blocks() fails, the helper
> stops scanning but previously returned success. Errors from
> ext4_find_extent() were also discarded, so replay continued after an
> incomplete bitmap rebuild.
> 
> Return errors from the helper and propagate them through both replay call
> sites so journal recovery aborts when bitmap reconstruction fails.
> 
> [...]

Applied, thanks!

[1/1] ext4: propagate errors from fast commit bitmap rebuild
      commit: 283e0c44a7256634921afa9689597c4ebd99677a

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
