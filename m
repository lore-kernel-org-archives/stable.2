Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795584593;
	b=c/vjbcm5+nc+iw/JJxdLMdOqTOokF13c74tVYWVXwN8lTYa8AHuF9+2i59/ExS8QDJci
	 rO71d45pKptzIDW34xxKE1K8tVa5O2u8Nx3YuatLjHlAudFOCWaydcwKuhug6qvtYCEHR
	 633RHLIIrjUWkebrmXXBeQf9kwm59rcTeh+0md0ZsIs7bfa1Pk+Ea4Yyxb3dKHwxOjAZw
	 BLE4AtSSQv0da3g/lu8ytiPrCQJmvG6vsk2S9+l7oMSm/CSl8QIHHI1iAMn1CHwEHQxQr
	 r+D4kBtrB7zSEjQr+ELjAsZIEVnv3vhx3KhaIcv94I86KkklgJd25YldBFf1G+9qh9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795584593;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=e3wyAnld0cja08o+K8kc6TksLNWRmfmK6BdoyJ+NbF+fv7NpLzJ4bZpXpJRGV9WSjJ5K
	 Gpj7bZxBfKDS22FyTR34h9huzUjKGhPQJuQushkeRZ0UlCgxwhrgm4bsUaisGdFaMgX6C
	 pczBpo8kJPDIQ/0PjoVNPnUdT046azJ9QE4ZpvALUTqetj1xLwSb8f493Fc8dqQ5TT2Uv
	 Ew+i9JuvM8DkP4rw06qtBzWC/atkEqSgZRfXhTKQyDQoyWKPEif9BrG9o/W2hWM9Z70hu
	 Bxc89lKkeiAVrnTzUJXN5vg2UjIMZNNv7z1UUupe3BPdN9FSvcfEca6QShvOf2W4aFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAD5606A327;
	Wed, 25 Nov 2026 05:29:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EAD5606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C928B68AFE; Wed, 25 Nov 2026 06:29:48 +0100 (CET)
Date: Wed, 25 Nov 2026 06:29:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Dave Kleikamp <shaggy@kernel.org>,
	jfs-discussion@lists.sourceforge.net,
	Edward Adam Davis <eadavis@qq.com>, Jens Axboe <axboe@kernel.dk>,
	Ming Lei <tom.leiming@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Tao Cui <cui.tao@linux.dev>, Al Viro <viro@zeniv.linux.org.uk>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev, linux-block@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+cd8a9a308e879a4e2c28@syzkaller.appspotmail.com,
	syzbot+ecf51a7ccb6b1394e90c@syzkaller.appspotmail.com,
	syzbot+bc273027d5643e48e5b3@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] jfs: wait for lbmDONE under LCACHE_LOCK in
 lbmRead()
Message-ID: <20261125052948.GB20286@lst.de>
References: <20261123-work-loop-backing-file-v1-0-48f83eaf2499@kernel.org> <20261123-work-loop-backing-file-v1-1-48f83eaf2499@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123-work-loop-backing-file-v1-1-48f83eaf2499@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

