Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC9410F1;
	Tue, 18 Aug 2026 01:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787015837; cv=none; b=hGB2rfqJiUcNlImlpmARV+wcbF0GDDJSUpFo9tzOILTmXX+PbvzK1B9xXsyHGsMKRXs6JRICTxaj71usMJhWrWmWpab7AALsJjhLKpB3Kbdl1eDIVv/zK80fz74Jf51LCNIUfj3DowEI9t0mWqQBglgJvfoDsAYZhDOPn5zR1g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787015837; c=relaxed/simple;
	bh=2HGCg/DE4itQgrkWf4etwHHgoM+Mciay/ZLzOF8Q9z4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L0iPJOVByfNHovWR9zOshFKl/uAI8fDmmu+NKN3a1JdBdbJmpwF+LyoToyn7txJwRpLljvd2uzmmy0ZVEfGiVk3UGV9fjoVoTt+lf+4ufcWCE2NHOyV7FlxaxpwyJd1j05ROj3GYSve0bs2Vht3D+eXZZEyL9f+XzrFRkTUW5CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8a2a698e9aa211f19a56ed5b684f684d-20260818
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:17eb5614-ab2a-4efb-ba35-648acf85ad1b,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:7db8b62,CLOUDID:06ff1fd76e6d94177b22379aaafa4062,BulkI
	D:nil,BulkQuantity:0,SF:81|82|83|102|850|865|898,TC:nil,Content:0|15|50,ED
	M:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8a2a698e9aa211f19a56ed5b684f684d-20260818
X-User: gonglinkai@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <gonglinkai@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1794351527; Tue, 18 Aug 2026 09:17:11 +0800
From: Linkai Gong <gonglinkai@kylinos.cn>
To: David Laight <david.laight.linux@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Zimmermann <sigmaepsilon92@gmail.com>,
	Peter Korsgaard <peter@korsgaard.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	John Keeping <jkeeping@inmusicbrands.com>,
	William Wu <william.wu@rock-chips.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Ethan Tidmore <ethantidmore06@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Chris Wulff <Chris.Wulff@biamp.com>,
	David Sands <david.sands@biamp.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Linkai Gong <gonglinkai@kylinos.cn>
Subject: Re: [PATCH] usb: gadget: f_hid: do not copy_from_user() under a spinlock
Date: Tue, 18 Aug 2026 09:17:05 +0800
Message-Id: <20260818011705.3840602-1-gonglinkai@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260817154604.70427ed1@pumpkin>
References: <20260817154604.70427ed1@pumpkin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 17 Aug 2026 15:46:04 +0100, David Laight wrote:
> How about a patch to remove the ERROR() from the earlier copy_from_user()
> error path?

Agreed. A failed copy_from_user() is a userspace error and should not
spam the kernel log. I'll send a follow-up that drops that ERROR().

Thanks,
Linkai
