Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794569650;
	b=cZC+mIiJFeDfksLb9KEeeeA+44Bu2h5Zlx5VKsS8Ug82qmLHutw+L47bNoiiqlbucuxo
	 JjyXHVBwwKxn9uO+YdOgXylmvDzM269q9W2/XHNJmHejy58+hSjJvtDYdA6ZiPLV07Bxe
	 CI2Vld854w9RFzijVmklDcdQpeP9NHBuBCzLdG5Wsl6OGQwSSpFtk9OGbxdSFNB3g1OMo
	 FjWgx95MN1MDUiOgAb1pmUjr57xd0GbTI0CQAWacpaVRrZeW/lPRjcaQth3Seru0MGsE+
	 IivNpqh2KAYQqgSgFc4uDcZE7Y6kWdLGkLoKIoFGXmxPCz+WjqMgREN1iaO5i0v9djg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794569650;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=oIdNU+YTvpaI3LmefHUJ7igvr6HXe1LnOHaj9fZpjyY=;
	b=X6Jn0CPL88ScSOyw0JUeaQhcjRu84BbtweQReVXrbRzybd4PFlH/7ZxpffM+uui5WBHB
	 RCJ4F4zturQ7mM5dDY7vIrFsqRp4VULjoiQHDV0jVAB1qs1PCdTHP/JlCFybFicmV+5rj
	 J3qOZGYlxpi3yK3Fu2WmTLj0iQ5aq7HA5HKQ/nWeNTr4DVx18UY7P9ly5LAyJt78Pt8kN
	 GFs5Qd0ezZrNnI7oRh8XdV/+ew4yLpGIBHu4Sm3sNvMc3l7Vycdvq5dgwnajXru64ulvF
	 WXPikQ+9p5A012QO9vUuBeFqUfXPVw4tojg5pCrxp+JfIi2Jkfuba4e8biqgx46OtMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="JnCoTw/t";
	arc=none smtp.remote-ip=74.125.224.139
Received: from mail-yx2-f11.google.com (mail-yx2-f11.google.com [74.125.224.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803A5606A31C
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 11:34:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 803A5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JnCoTw/t
Received: by mail-yx2-f11.google.com with SMTP id 00721157ae682-8b3b57f3634so3786557b3.0
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 03:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794569649; x=1795174449; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oIdNU+YTvpaI3LmefHUJ7igvr6HXe1LnOHaj9fZpjyY=;
        b=JnCoTw/tSrUxuvMZtqMSu+il3ucnqIIjqr+WdAAyzwqwTJMwVAwlAcKCq89RkTJpMC
         ib+I7kqXuOl04LSPfPZDNQN6WOPidJFKsl7X6KyRHSrLAJ9UuSoPrB0KulZs/vWmUAc4
         4CRFbz+xtE0lat95spUidjYe1vxZAZkE5F3dnggXCMPnYdnlRfSGt9lgj02k4OzUcJ/n
         zS2vKy0DXHIIWhOal2Twj/oDt2KvK5/SS4JNWqmCNmyk+6Qy/SrpTsB0OxsjOpy5QpgP
         z9KpZ5IWzY2cCagceQyXW5WOTqqi8ZyUBiRlvkhZ7PiycpQ3omd5C3g6rAgoKx0HWLw/
         MAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794569649; x=1795174449;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oIdNU+YTvpaI3LmefHUJ7igvr6HXe1LnOHaj9fZpjyY=;
        b=OademByBI9oIZYBn1xBH3iQ1Zh0gdFgL674WgBMN0QwdlEUumoUpGZxw8w1m2sngBH
         XdwLzXd9s0G2oSI28VUp/DOsf5IDBQEUaETS+iRQ6YoNHbptusUHgojb/HbIHxQu3HCP
         wXDq+V/8u2NIc2pUIoiSfkq2YpMIAbC/svzoHmZikUAwJhnPERz9OZHZWyQEvjrwt4GU
         W/AMzPB+2j+RYHpC9zTxAwi/7Ggsn6FVPisK2gzMFua+114/GmiRO8juMRIh1vNv7dGv
         jJgk+gJSfuza345395S1TWrH9jgpj4i3xtq5cjPTuGNPb+BRU0chYhVbNcdC85TrLMkb
         w2LQ==
X-Forwarded-Encrypted: i=1; AL+hErGSfOXydx9SFVYsOUwT0TXv1DmFJoHUMWnLm+tu6Jl8wYqKNN0FgTK+x1aP9/GE1RWooFan1tk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/wLWwbcB2mlBIGsq8bGHGo1t7h+P/cNgi5hZ0e7r728usOzIGq
	kWY3Lo6iB/qnsu2/gWj93oQyHgtz94kciX0Xq5zCrXJbK/qaYEnEllkn
X-Gm-Gg: AYBFou1diGtWUEOqog2kQyuZsDpqb2tojmpdaf8P5j1EtooRZ5eDcTBeuFPMW3KEHYt
	qgwzUNZ9DY75+VTSahT1Lh/s7r4T7C7T4IIk8SyMlDcpgfZOx28rX0XwzKBXc197fwh9v4Xxkta
	oafegwe7ASSWsJ14eJ0sRP6rZ3WfgbQdc8jwj90/yCUsctYZVN+UWkaUpFv+mB/EI0xeJq7nPb7
	S4zuvTjLPSwvCWkorTXt4EeRdUV+y6OiweXD0WkbZqY7isNfkQfy4sXEn5eA9b4tCyPRVtC8MSO
	QIYbb+wTcZmGDRon2D2MhonK52SCOJNg+hOIJ+fF6/i2+CTtPg0ZValtOtNxCqnfFShRTdhDU1l
	fuD73lA/dOi2BvchGaSdigKYEaS09aE790YXfjeFBRvehHpD/k/oPLKsdGFI5rgc/0soyG9T/EU
	/ngey7AIoot/RygPsKVZ0QcNl6nNKAqbvJohxDZAp37CB8NDrQVtA8YTzSuHUtWV8PiwM7yVmoR
	sTgCzJJ85vhqY1r7KYncoiLR0DH+GLwINgWB4ep0ilqgbNQg8KySWPaGzLC0WEi3HnnCfHENYLG
	a7HJ0jQybnRELty4z0le+OcmxGe42jfGYJ4s
X-Received: by 2002:a05:690c:e215:20b0:8b3:7782:675f with SMTP id 00721157ae682-8b4aa2a239emr7986187b3.66.1794569649432;
        Fri, 13 Nov 2026 03:34:09 -0800 (PST)
Received: from [10.0.0.48] ([71.69.222.122])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4aa9a7db2sm17420907b3.30.2026.11.13.03.34.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 03:34:08 -0800 (PST)
Message-ID: <bc96a186-5a19-4896-8465-ccd1df5a33bf@gmail.com>
Date: Fri, 13 Nov 2026 06:34:06 -0500
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
Subject: Re: [PATCH v2 1/3] nvme-tcp: use an aligned buffer for the TLS record
 type
To: David Laight <david.laight.linux@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Hannes Reinecke <hare@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Martin Belanger <martin.belanger@dell.com>,
 stable@vger.kernel.org
References: <20261111-nvme-tcp-live-ctrlrec-v2-0-6295202b84de@gmail.com>
 <20261111-nvme-tcp-live-ctrlrec-v2-1-6295202b84de@gmail.com>
 <20261112223707.3bf1e1a6@pumpkin>
Content-Language: en-US
From: Martin Belanger <martin.nvme.dev@gmail.com>
In-Reply-To: <20261112223707.3bf1e1a6@pumpkin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/12/26 17:37, David Laight wrote:
> Is that right?
> You are changing something that was CMSG_LEN(1) to one of CMSG_SPACE(1).
>
> I've a feeling it would be right if it was a struct, not a union.

I think the union is right. buf[] covers the whole control message:
the header, the data and the padding. CMSG_SPACE(1) already includes
sizeof(struct cmsghdr). The cmsghdr member only gives the buffer its
alignment. With a struct, the header would be counted twice.

On x86_64, CMSG_LEN(1) is 17 and CMSG_SPACE(1) is 24. The union is 24
bytes with 8-byte alignment. put_cmsg() writes CMSG_LEN(1) bytes and
sets cmsg_len to 17, as before. It then advances msg_control by
min(CMSG_SPACE(1), msg_controllen), so CMSG_SPACE() is the size it
expects.

This is the form that cmsg(3) documents, and the kernel already uses
it:

- net/sunrpc/svcsock.c, svc_tcp_recv_cmsg(), and
  net/sunrpc/xprtsock.c, xs_sock_recv_cmsg(): the same union, for
  the same TLS record type
- arch/um/os-Linux/file.c, arch/um/os-Linux/skas/process.c and
  arch/um/kernel/skas/stub.c: the same union for SCM_RIGHTS

The commit message of 1/3 names xs_tls_read_record(). The function
is xs_sock_recv_cmsg(). I will fix it in the next version, if there
is one.

> Did you test it?
> Or even compile it and compare the two object files.

Yes. I tested v2 and v3 with TLS records that carry no application
data, before the ICResp and on a live queue. These records go through
this buffer.

I also compared tcp.o before and after 1/3 (x86_64, gcc 15.2). Before,
cbuf is at %rsp+0x77 in nvme_tcp_recv_icresp() and at %rsp+0x7f in
nvme_tcp_skip_tls_record(). The stack pointer is only 8-byte aligned,
so the struct cmsghdr is not aligned, and put_cmsg() writes cmsg_len
to an unaligned address. After, the buffer is at %rsp+0x80 and the
stack is aligned to 16 bytes. msg_controllen changes from 17 to 24.
The other differences are register allocation and stack layout.

v3 has the same change in 1/3.

Martin
