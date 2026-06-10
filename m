Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD5E3F4109;
	Wed, 10 Jun 2026 11:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781089305; cv=none; b=tmGUGvTddm5iLJ/dLBR1wzrm1TY8jUexMiSKvpMj65EBDMna3EnnI24FOZgOea+r90Rm72Ro2MYndlRqqb7GliIIPvfiax1ujjc/jhe+Q7unKHt4GVxcVM/cjXIHhjiC2AbAmNRC4bpoqjyTEWQTVZiRK4ZDRpO1cn0utXhaBq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781089305; c=relaxed/simple;
	bh=aBMlI5GynG8PGFL9oQvJmX7hmUnCvdv7groipJ0VJME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MCfJZSUKi1HlgdRHuU0THk0WH8Gc7Om27cludHPJLFWX+MbiPldLpe08cC0zei4A71KI19jbPcGjCA7EHeT1JG/6FEobhWcI+NJszxyvGpkTz4vzA8hvUqpn2nHn6oiAOeBtywz4Ub5zdFwowfHjG3VLzI5Lem0elyjYV7M4Kd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 65AB1Fte097171;
	Wed, 10 Jun 2026 20:01:15 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.5] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 65AB0k38096905
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 10 Jun 2026 20:01:15 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <075511fc-1136-4208-84d0-9214e761f8ba@I-love.SAKURA.ne.jp>
Date: Wed, 10 Jun 2026 20:00:47 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath6kl: fix invalid workqueue flags in
 ath6kl_usb_create()
To: wuyankun <wuyankun@uniontech.com>, linux-wireless@vger.kernel.org
Cc: jeff.johnson@oss.qualcomm.com, johan@kernel.org, kees@kernel.org,
        sumanth.gavini@yahoo.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzbot+f80c62f371ba6a1e7d79@syzkaller.appspotmail.com,
        stable@vger.kernel.org
References: <20260610092236.40026-1-wuyankun@uniontech.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20260610092236.40026-1-wuyankun@uniontech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav405.rs.sakura.ne.jp
X-Virus-Status: clean

On 2026/06/10 18:22, wuyankun wrote:
> ath6kl_usb_create() currently creates ath6kl_wq with flags set to 0:
> 
>   alloc_workqueue("ath6kl_wq", 0, 0)
> 
> This triggers a runtime warning in __alloc_workqueue() because the queue is
> created with neither WQ_PERCPU nor WQ_UNBOUND set:
> 
>   workqueue: ath6kl_wq is using neither WQ_PERCPU or WQ_UNBOUND.
>   Setting WQ_PERCPU.
> 
> Set WQ_PERCPU explicitly to match the actual execution model and remove the
> warning during device probe. No functional change intended.
> 
> Fixes: 62ebaf2f9261 ("ath6kl: avoid flush_scheduled_work() usage")

Please use

  Fixes: 21c05ca88a54 ("workqueue: Add warnings and ensure one among WQ_PERCPU or WQ_UNBOUND is present")

for this problem because this problem is caused by

  WQ subsystem is about to start requiring WQ_PERCPU unless WQ_UNBOUND,
  without updating all in-tree users before start emitting WARNING: message

. Also, you don't need to send to stable, but please try to send to linux.git before
7.1-final is released (because this fix should be applied before 21c05ca88a54 is
applied in order to avoid flooding of WARNING: messages).

> Reported-by: syzbot+f80c62f371ba6a1e7d79@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/all/6a289c01.39669fcc.33b062.00aa.GAE@google.com/T/
> Cc: stable@vger.kernel.org
> Signed-off-by: wuyankun <wuyankun@uniontech.com>
> ---
>  drivers/net/wireless/ath/ath6kl/usb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath6kl/usb.c b/drivers/net/wireless/ath/ath6kl/usb.c
> index 79c18f5ee02b..945984c3dbe6 100644
> --- a/drivers/net/wireless/ath/ath6kl/usb.c
> +++ b/drivers/net/wireless/ath/ath6kl/usb.c
> @@ -636,7 +636,7 @@ static struct ath6kl_usb *ath6kl_usb_create(struct usb_interface *interface)
>  	ar_usb = kzalloc_obj(struct ath6kl_usb);
>  	if (ar_usb == NULL)
>  		return NULL;
> -	ar_usb->wq = alloc_workqueue("ath6kl_wq", 0, 0);
> +	ar_usb->wq = alloc_workqueue("ath6kl_wq", WQ_PERCPU, 0);
>  	if (!ar_usb->wq) {
>  		kfree(ar_usb);
>  		return NULL;

