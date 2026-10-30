Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793350946;
	b=bnLJO+kxB4rVkqcgJTw3dn7qKHw5JE7YFPwhtQ156r6hKWIe48310cZ+hF9gJ/7ifMih
	 wXLCLfTvvj64s8q2/bC5wf7vU5b6Mv6s0Xe2jeVALVW+5Y8UsV3SlOKSX7SqQnT+P5S1i
	 YcgFBLxOQjmZkK2vOcjwokI6WCI4hxvkbuwBQeSxY/FjJV+NV3LY8ZUH+7ZoNC1f7yRmc
	 a7I1/UdttZw6J2LU5p/8QV7QbgXfj6shLy9qA5bhPgS2fMFManmgwqKBSpMLlHrFfkRio
	 csba8AQfrkqz/KIrkhWltHUeBC98xhF0KI6aHW/Xwrmr/eG8ks4+L65tGaaohnR3mrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793350946;
	h=DMARC-Filter:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=EboqprzWKR1TmB59Ku9/L+t9P/HJHq4mAjFlDgZxalA=;
	b=ZJUdGCRaWyUj8139OumOTg4WXkeCxFef73pm1xcIFEUXCasCRJ+IWhM/34MDTXQ51AAY
	 yvtsDeX7IQk/A3KtvbGOGnx4Wg34/RJuS3+CsqMkRcmZ5Ch7yXQmYH3pLRa2ShW1NN0i2
	 ZPT24STEEpaSzmzh6RhZjZjIhKidTXilpENiQEHhWmpuT6DkUVghDBaI9BAAgrvGcLKzt
	 2g+gFbfZfGtEmoZey6LYBe9mFMMMafwDmWIBHlb0mZEU+7XGQwWVAHDd/Djvtma8gnZV1
	 7OL4yNkDCQqpbTBF28lJze5K2+WC2ZgWknqfBQkE4hR/h9o4MVzw51AlrNtmfJyyALw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=126.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=ptDd7pi4;
	arc=none smtp.remote-ip=117.135.210.8
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39346606A31E;
	Fri, 30 Oct 2026 09:02:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39346606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=ptDd7pi4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=EboqprzWKR1TmB59Ku9/L+t9P/HJHq4mAjFlDgZxalA=;
	b=ptDd7pi4zg/am05pHUprpzLk74rZiQPZHtiypWLiLyCUMpfNTKXl8OPzqm+cu6
	QzOr95TPDfhtpMHU6cOwSOPj6zcolA8By7/UWF9RTvjQz0tAR8E4qt3lIvZBRho7
	ZHdcWVD2iDhDz1T6Tv2SgAuqf/RulVDRjTIgqwMGOoHXk=
Message-ID: <1093eae1-8ceb-4a6b-9dcc-077e977e4ceb@126.com>
Date: Fri, 30 Oct 2026 17:01:22 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] e1000e: close and reattach the netdev when
 e1000e_pm_thaw() fails
To: netdev-bot+sinfo@kernel.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linkui Xiao <xiaolinkui@kylinos.cn>, stable@vger.kernel.org
References: <20261028093117.2313438-1-xiaolinkui@126.com>
 <179318011223.3327.3243826211150431182@kernel.org>
Content-Language: en-US
From: Linkui Xiao <xiaolinkui@126.com>
In-Reply-To: <179318011223.3327.3243826211150431182@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3N_rjXORqiXBABw--.10056S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr43WFWrur17Wr13Kw15Arb_yoW8CFy5pF
	Z09wsFyFn8JF1IkF1xXw4Iva4FqrZ3GFWUWr47Kryj9w15CF13KrZFgw4UCa4DCr93Za4F
	9w4jq34qyFyDZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UZZ2-UUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqAQk+mrkXOQdRgAA3f

Hi,

Thanks for the automated review.

On 2026/10/28 17:35, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>   - How the issue was discovered, e.g. hit in production, hit during
>     development, syzbot report, manual code inspection, LLM or static
>     analysis tool scan.
> 
>   - Whether the issue was actually triggered, or is only theoretical
>     (e.g. found by code inspection). If it was triggered please include
>     the symptoms, like the stack trace or error messages.
> 
>   - What hardware the change was tested on. For driver fixes please
>     mention the device (and if relevant firmware version) used for
>     testing, or say that the change was not tested on real hardware.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

Please find the missing information below.

- Discovery: The issue was found during manual code review/inspection of
   the e1000e PM thaw error handling. It was not reported by a user, syzbot,
   or a static analysis tool.

- Triggering: The issue has not been triggered in practice. It is based on
   code inspection and is currently theoretical. I have not reproduced the
   failure path or collected a stack trace/error log.

- Hardware testing: The change has not been tested on real hardware. No
   specific e1000e device or firmware version was used for testing. It was
   only compile-tested.

I will include this information in the commit message if another revision
is needed for other reasons.

Thanks,
Linkui Xiao

