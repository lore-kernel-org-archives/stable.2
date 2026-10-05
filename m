Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A22490BF8;
	Mon,  5 Oct 2026 15:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791215639; cv=none; b=XDVkzSb+8tYf2gOGWv4RqgMA50htJSj7HNDlRtmTvzwd1TslknBpmIKRwsyqBQrBgzm9CZacTP76Ib9NUhI8fqGi4n5iacIcdFvcI3XJ7CCZGPI2tZaZ8TabWyrNwiH0f5k1I6gtg+oi0oYkuSP7Ehf+j46zZXxxsynaVtdBpY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791215639; c=relaxed/simple;
	bh=yIKo1AJ1FszovPUPiumxVNTmhCJq3pJkyQuQoYy800c=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=h2cm3HbpEj+Uil6CGkBMsinS+l3m+9MFtvdCzidQA49SskFmSWjsXT3xodRKIMLGBBx0t6sY63dgpyjSywPHkWEevRFdjnAoZhPpPj5lmaRp/Qzqpb+241IoQGHs8SightaIJoWboa4bXYzQJ0PnMXrvNGf7oXEg9BNxOrdZelc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=As/Kjo2w; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="As/Kjo2w"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=3G9qvE89+Iie4JuZVMlOcEW2PUizhApfcs7A9V3YHG4=; b=As/Kjo2w8lMyhEul8Bo6YgiaPU
	ACUyBUha7TFju+SoNlkImh6iZSpT3YdHi7IvR039tEBRvO8cYDtmLtZk6wtu5+syBzdx2RpR9b3F3
	8UUkssfm1GtkanW3Jc8bqlnlk0N2PpoTh0fxHbE3nHqCvLBjSdyQ2Yw4VXOoABdX4PprHLri0QF71
	a+pDIpZ0NZfMG1dKMbOqcGGXER+1H1cvzNe2qKCCy/AL8rE8AOUt//bgWMogdERqQrivmuRYYzW1m
	3xwqsq/2hYzmq111uO7CfanQa65xXLogBrzwy28WFtY42EKVimIlEXrVt7jeyWC35Urbrn8VP00Sh
	9iveQgBQ==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1xDl0g-00000002IxF-08qV;
	Mon, 05 Oct 2026 09:53:50 -0600
Message-ID: <1005631a-5234-4a3a-9edd-a4ec299c168a@deltatee.com>
Date: Mon, 5 Oct 2026 09:53:48 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yogesh Gaur <yogeshgaur.83@gmail.com>, Song Liu <song@kernel.org>,
 Yu Kuai <yukuai@fygo.io>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 Li Nan <magiclinan@didiglobal.com>, Xiao Ni <xiao@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
 syzbot+270624bb31d478afe62e@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20261004060203.1379-1-yogeshgaur.83@gmail.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20261004060203.1379-1-yogeshgaur.83@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: yogeshgaur.83@gmail.com, song@kernel.org, yukuai@fygo.io, linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, magiclinan@didiglobal.com, xiao@kernel.org, hch@lst.de, hare@suse.de, syzbot+270624bb31d478afe62e@syzkaller.appspotmail.com, stable@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH] md/raid5: set conf->mddev before the first setup_conf()
 error path
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-10-04 00:02, Yogesh Gaur wrote:
> free_conf() starts with log_exit(), which falls through to
> raid5_has_ppl() when conf->log is NULL:
> 
> 	static inline void log_exit(struct r5conf *conf)
> 	{
> 		if (conf->log)
> 			r5l_exit_log(conf);
> 		else if (raid5_has_ppl(conf))
> 			ppl_exit_log(conf);
> 	}
> 
> raid5_has_ppl() reads conf->mddev->flags. setup_conf() only assigns
> conf->mddev after bioset_init(), but five of its error paths -- the
> pending_data, alloc_thread_groups(), conf->disks, extra_page and
> bioset_init() failures -- jump to "abort:" before that, and abort: calls
> free_conf(). conf comes from kzalloc, so conf->mddev is still NULL and
> free_conf() dereferences it:
> 
> 	BUG: KASAN: null-ptr-deref in raid5_has_ppl drivers/md/raid5-log.h:54 [inline]
> 	BUG: KASAN: null-ptr-deref in log_exit drivers/md/raid5-log.h:128 [inline]
> 	BUG: KASAN: null-ptr-deref in free_conf+0x81/0x5d0 drivers/md/raid5.c:7549
> 	Read of size 8 at addr 0000000000000028 by task syz.3.20/5681
> 	Call Trace:
> 	 <TASK>
> 	 free_conf+0x81/0x5d0 drivers/md/raid5.c:7549
> 	 setup_conf+0x1720/0x2ad0 drivers/md/raid5.c:7885
> 	 raid5_run+0x8cc/0x2560 drivers/md/raid5.c:8129
> 	 md_run+0xc3d/0x1cd0 drivers/md/md.c:6779
> 	 do_md_run+0x35/0x720 drivers/md/md.c:6880
> 	 array_state_store+0x958/0xe90 drivers/md/md.c:-1
> 	 </TASK>
> 
> The faulting address is offsetof(struct mddev, flags).
> 
> conf->mddev is a back pointer that is constant for the lifetime of the
> conf and does not depend on anything computed in between, so assign it
> as soon as the conf is allocated. Nothing between the allocation and the
> old assignment reads conf->mddev -- alloc_thread_groups() takes the conf
> but never looks at its mddev, and the rdev_for_each() loop walks the
> mddev argument directly.
> 
> All five paths are allocation failures, so this needs memory pressure or
> fault injection to hit, which is how syzbot found it.
> 
> Reported-by: syzbot+270624bb31d478afe62e@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=270624bb31d478afe62e
> Fixes: ff875738edd4 ("raid5: separate header for log functions")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Yogesh Gaur <yogeshgaur.83@gmail.com>

Looks good to me, thanks!

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Logan

