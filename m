Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793201703;
	b=sDS/jBu8SPlYI8LtytlXICw+4VZHpM3lIQ3ljmY0qmOC7Vsy/lHmgNcWRJGNX+SxIjNl
	 y1ptFpXB/P6RUkkSoTbvoM4asxUXE/Y5KaFBhzTcDpZvYG2tp27JN2f/+RLNLfuALFmOf
	 M0tyZ/khT1Y8bmYDDtSEMLJWTjfe9cRlTz0UyGCPCWcAd9TxWcx5JZLKCaSOhYSLQLNuh
	 PHMgJwAOk67w1rkTIRDwBhsX3RWfOj7oqjsiwsHowupDfvtD9D/5OCcKiBiqfz7Q9+eYL
	 6T5EoMfbLzqFCxJGUHhhznmolHrClz0EaJ0mGXx7tO8Nzc4vOWm5c8/VPsRZ1rPFp3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793201703;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spam-Status:X-Spam-Checker-Version;
	bh=Jyx/jeRAcaqdXajcAK6tjJ/1/ZoaiYYTOf9o+ArayOo=;
	b=upaUpTJgXodvTBlXayyF0/vAdg14xjw5/53tTJP9IkW8OvRorHRzZ2KBzeIkryiUOQJ/
	 qRHB8Nm4Tssabe04/GPFRksFtg1YYeHnT7ginhnV4zNJE4X+WyaFCyVeJ/rJ40Pgjt/Vz
	 m9aP5vnbOpcJBz5Pt/Imli6yHP+IbATQyDEPctJnRHmo2Q8lPRRBxC2qxgInjcbjCNzGv
	 pUcPXaNDQRrvX7ZMyONSl7VosgzRYYYEonoWGNDEV9g8Fc6viJbVf1Gt8gCqWmmCOnkhc
	 +W3Mq2VBZbsdwsD7mTG48MN4Y01pi0sMk5aWa3GolHOfm7MxQC63mk1ufvJC6oSDdsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=K6AULL7o;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3026F606A336;
	Wed, 28 Oct 2026 15:35:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3026F606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=K6AULL7o
Received: from mac.lan (unknown [52.172.102.253])
	by linux.microsoft.com (Postfix) with ESMTPSA id CBC7F20B7166;
	Wed, 28 Oct 2026 08:34:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CBC7F20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793201690;
	bh=Jyx/jeRAcaqdXajcAK6tjJ/1/ZoaiYYTOf9o+ArayOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K6AULL7oGmJRSn7IrV7tqJi9cmnJmGIeUBJvr9ISwBsVyY//q9bEaffwDmrUVQ0KZ
	 Wzg4VXDwP7KD9GUC0wAJZHqLMKkr1KLHUlLlKN1lrXvz4oucTXhaHZcY8fXHpu3qYJ
	 VJWQ8ZdTvN3jz48CNmwiehyih6d4WQnlLdPt+e4E=
From: "Cen Zhang (Microsoft)" <cenzhang@linux.microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev-bot+sashiko@kernel.org,
	dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	mazziesaccount@gmail.com,
	greearb@candelatech.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	Cen Zhang <cenzhang@linux.microsoft.com>
Subject: Re: [PATCH net] ipv6: fix fib6 walker UAF on NLM_F_REPLACE
Date: Wed, 28 Oct 2026 11:34:44 -0400
Message-ID: <20261028153444.67719-1-cenzhang@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019170909.7b065b7d@kernel.org>
References: <20261019170909.7b065b7d@kernel.org>
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

Hi Jakub,

Sorry for the delayed reply. I'll send v2 shortly.

On Mon, 19 Oct 2026 17:09:09 -0700 Jakub Kicinski wrote:
> On Sat, 10 Oct 2026 22:55:27 +0000 netdev-bot+sashiko@kernel.org wrote:
> > Should w->skip_in_node be reset here too?
>
> Sounds legit on the surface

Agreed. I'll address this in v2.

Regarding the other points in Sashiko's review:

> Can a resumed dump skip the replacement route rt here?
> [...] It moves walkers on iter to iter->fib6_next, which comes after
> rt [...] The dump then contains neither the old route nor its
> replacement for that prefix and metric

Yes, I reproduced this behavior with v1 applied. I'll address it in v2.

> can this store race with the lockless walker reset in
> fib6_dump_table()? [...] The same race already existed with
> fib6_del_route() as the writer.

I agree this is a pre-existing issue. I'll leave it out of v2 to keep
this change focused.

Thanks,
Cen
