Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794713880;
	b=eYWtRoMUqAuHHjVA/DW6pUsg8CBPS9iv6SrQwzJaMf6Q+2v/Lu1t4m++tXZw6nodUTe8
	 GKuYsdvXuu07a9NetuY2rl7ox9EOqMRiO8FFe9bwO/+QRuOaGDkNRHa/rG0C8t28UEqe5
	 dq5bpFLfUdafCtMWKhuFaKlGbYmrL+g9Vqiw1hFeiwVMFRyeN103hxCCs7JIJuj0o5N9V
	 aLlidRRgxyAlx6DLB1saH/KP5gEo5L6q3Wjt0QRDB6+AL7p873Ho084QUDUmylJnwZT8R
	 +W/oXlzn6B+j4SKc/xleLTs0UeyXWdKQFL3L4DERGWLRRWqh1CmXLPKWxLGfW7SJ1HA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794713880;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/1T6bTXwk3JqyIk3KCM5DkYhYn4GwL7gAgdTwegmW8g=;
	b=NNwFu+BjzfyA4awEbZcMxsmhNBv/GwRjXa8nOvPvtEsSeMbK/CRner53O28HtX1Qrm3l
	 uLDrNy4a4Bpoq8FSriOTcXi6MijZN1SzSypy3lgLkUirE7N9rMhJ2wqUgG/9T+pv1hEo4
	 XDLzT+JCEKsPt6de5W5lPMzy3x+0CV4sW/m1+s06lbKmDUxZR026GvnCsYaRwxylmxQR1
	 8PFUTUhQtepftONizQd48hq9ekP2Lro6mWUXZUN2vxbaTkY/RQiS8mRNqVNdWKtLs1g7w
	 nvgkiUoPC0aemymJeCCVYhtG17Ssn4ZcfBDX6FMN1s/4Yf2vtIT8chqcyCTQTUjkzmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=udXbnvDD;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8058606A327;
	Sun, 15 Nov 2026 03:37:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8058606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=udXbnvDD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=udXbnvDDvz9rSvZInRSvnmA90R8dT6++woplHICTfQ9u4jE1Kpj5G5bG5gjZnAL8NRPhc+okC244R
	 sDaRgwMttLXQfqOOrup0gq8aK6Rc+IuoB1mck4MEt66HIdEygiGqrq3J/GLMD/J96FHqaUGfkUBfMZ
	 tr0opztbdESVdjF0=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee96af92907915-f9e95;
	Sun, 15 Nov 2026 11:37:52 +0800 (CST)
X-RM-TRANSID:2ee96af92907915-f9e95
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from FHD-W7400297 (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee86af9290ea3f-577f1;
	Sun, 15 Nov 2026 11:37:52 +0800 (CST)
X-RM-TRANSID:2ee86af9290ea3f-577f1
From: Aibing Chen <chenaibing@cmss.chinamobile.com>
To: bvanassche@acm.org
Cc: axboe@kernel.dk,
	chenaibing@cmss.chinamobile.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	horms@kernel.org,
	josef@toxicpanda.com,
	kuba@kernel.org,
	kuniyu@google.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nbd@other.debian.org,
	pabeni@redhat.com,
	stable@vger.kernel.org,
	syzbot+b29ed72382b0e218323a@syzkaller.appspotmail.com,
	willemb@google.com
Subject: Re: [PATCH] nbd: do not reinitialize a live socket lock when reclassifying
Date: Sun, 15 Nov 2026 11:37:49 +0800
Message-ID: <20261115033749.827-1-chenaibing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <426d5936-54aa-4b4a-b70f-73f506c5a902@acm.org>
References: <426d5936-54aa-4b4a-b70f-73f506c5a902@acm.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Bart,

Thanks for the detailed review - all three points are valid, and I
agree the reclassification approach cannot be made safe for a live
socket:

1. Right - sock_allow_reclassification() is an unsynchronized check
   and lockdep_init_map_type() clears lock->class_cache[] without
   synchronization.  I also missed that lock_sock_nested() keeps
   sk->sk_lock.dep_map acquired in lockdep while sleeping in
   __lock_sock(), so reinitializing the dep_map while another task
   holds it breaks match_held_lock().

2. Right - sk_owner_set() calls __module_get() unconditionally, so
   repeated NBD_SET_SOCK on the same fd leaks module references.

3. Understood: as long as userspace can still issue sendmsg() on the
   socket, the original sk_lock -> mmap_lock -> fs_reclaim cycle is
   recreated regardless of the lock class, so reclassification does
   not fix what d532cddb6c60 aimed at.

I will drop this patch.  Are you (or Eric) planning to prepare the
revert of d532cddb6c60 and 9280e6edf656 together with the TX/shutdown
deferral to a workqueue, or would you like me to prepare it?  If you
would like me to prepare it, I would appreciate your guidance on the
workqueue design (nbd_queue_rq() currently transmits inline via
nbd_handle_cmd()).

Thanks again,

Aibing Chen


