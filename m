Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5063D45F8;
	Thu, 11 Jun 2026 10:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781174326; cv=none; b=VoK7grpLzFFBda+R01sayevjL2pmnTmW4TaOKNP+wbHI+wAzMelJG8pT/3ZM0lncN239TFHHvvNR57VHorDBMuALv2rpOl/WF3Cj0w4r6kbORQGuoobrWWDWHf+OMSROX8owjN8XlzSz/0oG1KvFFyJtSwKu5iKlDvVnmAf9EI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781174326; c=relaxed/simple;
	bh=Ox60/Qurnjavu4NZNXhSBK7a0gRFLOSnM4lCEXouXmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SELbKCwiD5gUG2kHwz1Hnt/QBh+wzAxcfa3pjWwL/xnpEsU3ITYBDWlnYjI5yuK+WTJBz30x42fsIH94aJl8fdoulGTJpGIk2eVonLVbTmL94ONhC85cG1Jnd+AKsz3WSLZSJfMMIc34avNEG0ZrK7W9+sdkjv66QouNYkefiWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from [10.88.128.241] (obninsk.basealt.ru [217.15.195.17])
	(Authenticated sender: ajratma)
	by air.basealt.ru (Postfix) with ESMTPSA id 31096233B7;
	Thu, 11 Jun 2026 13:38:36 +0300 (MSK)
Message-ID: <8a9fcb14-1fb9-4fec-999d-5f610f6edbb4@altlinux.org>
Date: Thu, 11 Jun 2026 13:38:35 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [stable request] mt7921e: backport two mt76 fixes to 6.12.y
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, linux-wireless@vger.kernel.org
References: <20260610080943.17734-1-rauty@altlinux.org>
 <20260610-stable-reply-0014@kernel.org>
Content-Language: en-US, ru
From: Ajrat Makhmutov <rauty@altlinux.org>
Autocrypt: addr=rauty@altlinux.org; keydata=
 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
In-Reply-To: <20260610-stable-reply-0014@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sasha,

> I'm going to hold off on this one. The second commit, 5ed54896b6bd,
> introduces a reachable dev->mutex self-deadlock on STA-remove-while-ROC;
> the follow-up that cures it (d5059e52) isn't in any stable tree and was
> never marked for stable (it's only in linux-next so far).

Thanks, and good catch.
I'll resend the request for all three together as soon as it lands in 
Linus' tree.

Note for whenever it does: when applied to 6.12.y, d5059e52 needs one 
trivial
change - keep del_timer_sync() instead of timer_delete_sync(), as the timer
API rename is not present in 6.12.y.

Thanks,
Ajrat
