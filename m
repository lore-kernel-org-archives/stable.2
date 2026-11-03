Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793703479;
	b=Hsf1NO9D5GpuVZk4OLNro5z1ZWkcuJQZ5YkWX67daTAVKBBdhlBaC/BjyA2E9OPd/KCP
	 6Sh9Dtk+nncoN+hOzSY6hGhrZ9Qe83HuZLx+AFW7muM4bZ1wYXd/EGEuAL4ADAUKUFHQj
	 iddtSkcyYT0aFYk6W97jjzlBGxiKtqGVrmGie6QuSf3TdApkJ42W5KnHEOFJk75qnX9Sr
	 jHVr4SphuzDhmwEHaIhxWR63NVNXKQPCI8tk49S9MoSFCS242fgGsB1QKuFJk9QrvbBZz
	 xLzTPsJv4nsErRYbS+Y0jza/QmJjNd99tVpZUAYkFxfMxHZClGiaLvq+NlaJ5JyhjaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703479;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=uecybL+gqfrB8HHj3vVKJyhfRKn7L+ejiH5DOEaosNc=;
	b=ypA4bQrL0TM6IlflgZ1HE6LTRJRqsXssHQr9aKSmmSu4D0pANXqs5tZZsNnz/ZZ67BB5
	 m7hR7WdIN1RbPyEdr0Rxixnc6gc+9dv4MFnCbhmk9al9JHwWBoDHf5pFk5w/8trMczDJz
	 /YXNmiNeLSi85y1j5hdSoU94R4S7Q3EUmwflcJsAl6IiLM0MOZ0m59k85A1KAN/ZJbM3G
	 Gz3oPpPT5vFJQ2iroriILhNFksxMpt9z2i52vLFPfd+Lyz5NYj8F7A0x77q5qY2A5r3AS
	 4Q0X9GddWz1ASBP1khrxr1BLwrYXno930Y04syTPLIrszVU18K+maY7RkfN2anR20zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bBa7T2lO;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=IR7HKpyH;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C811606C5B6
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:57:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C811606C5B6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bBa7T2lO;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=IR7HKpyH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793703477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uecybL+gqfrB8HHj3vVKJyhfRKn7L+ejiH5DOEaosNc=;
	b=bBa7T2lOJ+4pF2WLhuJ0Y1S/bo5D48zOxrbNpkeP0iS0LOi67rlAAT3sznN229mI9G3Cy/
	kMYmP/+nP8amZ7BywKn3sLSxA80NwooEqQggcMYv7ZUw/iT1mPr2fOtMRvjlPCJX6AHSyq
	apDQurP5hOTmEwx7YKaWSiT0Kzlockc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-YwUecUviOR2nPOnZGILFWA-1; Tue, 03 Nov 2026 05:57:56 -0500
X-MC-Unique: YwUecUviOR2nPOnZGILFWA-1
X-Mimecast-MFC-AGG-ID: YwUecUviOR2nPOnZGILFWA_1793703475
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48df730c035so2812079f8f.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 02:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793703475; x=1794308275; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uecybL+gqfrB8HHj3vVKJyhfRKn7L+ejiH5DOEaosNc=;
        b=IR7HKpyHpsu6vhKrQ2umLvoyYUPBYAXMIoBY7nB3Guu/f+JDm/h4J8Eu/Yde4UqUyy
         pwI1kjp429XrY3TRPE3QkcTlZmhy+Zui6gkCSUr0mxWKOl0Cx84ul0mY4+Woz3AktlBN
         PG+0YoaN1x0c2ZvdoVXkJswZJWBLMQ9fVki2P5xN3O9mnjKYKzysByPpWC/U/XKpthB6
         sXs3P84hbEpNBy0K0rrBeDfsDY9s7oStI78pwNsWs2+xoSL/xoVBGNMKhz4a3a1LVona
         dDx0JUDNe679Q4woAXHDbi7QJTWRWXo/RLnFCuGFfmwG+qLUTmcf+81v7R3C0Mdfv2ZK
         aB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793703475; x=1794308275;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uecybL+gqfrB8HHj3vVKJyhfRKn7L+ejiH5DOEaosNc=;
        b=Ap+K0GzxUw2TTtE2oGc6hxDQM8KChZQpjTD/Wi+ITKwk7YZCb7eBhhQHWZmwxhKs8G
         bYvPquFxvHbyKiAe3IE5QCTgO6TFoiEY1H9Ofkj4XHBE3qS+d1/LnNs+PIVB64SpAU7O
         Ac2vlzpVNo25JJH8ihy/s1ZC0lHMJFBFMzQvZtZEYjVbZBmQUcqF66ig1GNVIKH72ceL
         LtqGx74sc9dn3+xEInSszY0/4QjbiMDoDSboBzBNvknACvnwKBRMXIGZvDy4TENfmbJM
         I/zEuPp7R1PMYgfL3YpJ0jyoYQbLCNHL0E+/SlNT9qllmbzuzHpNn3qG3XUWCAOCNHYA
         Sgmg==
X-Forwarded-Encrypted: i=1; AKwUvBwRTLUtnej/mN/xm3Y7LAELkMm0+dlWATJV11QvgFUVpAi3qwy+QaBFxg6b7CzhG9xmVC5UtDI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9SZZo1sh2wOL7E/WeQ/bhTUjilNf56lf0uu55TgPIeFx0AZ71Y
	xqqGitcPzltwA59ApDXAA/8vGHOCaph63vBHn6es9IJH1gIExCG8WVS/LLfWa5Lr2MVlRkt2OfX
	UJoHrZ4J3K4hnOY/h2gvUShbTYwuOtshYdLlrh74amO6zwlGAla06750opQ==
X-Gm-Gg: AYBFou03d2P8exHGLj4+xUtxFSYdJzjcsMqx3JGXVawjCKrhyad5rz9RxvT7aNyXUfz
	cnIEOJd7+DvS00DaWcjf7K/BM+nWTHxPrkSgWQ8qpqFIQPN3X2P858N9DOG0igO1bso9535xJUs
	VAtwhuQTcoK1hTMMUjsKokeNwKQMcc43eLWrwvkSASocHxF3cT64a5CEUb4EbcrltDVwZIPDY6r
	ny2/8KdnsRn2qb5C18WcOBkR31m0pFa1rYNxFdpE/2GTvi6nNOiERx0RVzBNiLxFIOmwlHVCO3K
	IoNW3acYiYXwQ+JDnN2crGzLa0QJwe35qYNqDStuhBufHBAJZtLtx5kNuVBG8al7Dazs9Y7n1Mu
	WsiPTv1S2GG1THgH+UxtTgJUEyzFnVSw7xCMBm+vCUg==
X-Received: by 2002:a05:6000:25fd:b0:48e:2406:57d0 with SMTP id ffacd0b85a97d-48e6e2f6620mr27753774f8f.19.1793703474655;
        Tue, 03 Nov 2026 02:57:54 -0800 (PST)
X-Received: by 2002:a05:6000:25fd:b0:48e:2406:57d0 with SMTP id ffacd0b85a97d-48e6e2f6620mr27753733f8f.19.1793703474133;
        Tue, 03 Nov 2026 02:57:54 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1506:fd00:9e19:9994:44b1:e6f2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8c6e9sm24257782f8f.43.2026.11.03.02.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 02:57:53 -0800 (PST)
Date: Tue, 3 Nov 2026 05:57:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Fang Xieyan <fangxy@xiaopeng.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Guanglei Zhu <zhugl3@xiaopeng.com>
Subject: Re: [PATCH] vhost/vringh: reject zero-length indirect descriptor
 tables
Message-ID: <20261103055650-mutt-send-email-mst@kernel.org>
References: <20261102122942-mutt-send-email-mst@kernel.org>
 <20261103032935.58823-1-fangxy@xiaopeng.com>
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
In-Reply-To: <20261103032935.58823-1-fangxy@xiaopeng.com>

On Tue, Nov 03, 2026 at 11:29:35AM +0800, Fang Xieyan wrote:
> Hi Michael,
> 
> Yes, same fix - sorry. The October 21 posting is a duplicate
> of the v2 I posted on September 26:
> 
> https://lore.kernel.org/virtualization/20260926160755.21485-1-fangxy@xiaopeng.com/
> 
> I resent it as a new patch instead of a v3.
> 
> The !len form is equivalent to v2's len < sizeof(struct
> vring_desc) check when combined with the modulo check -
> zero is the only length below one descriptor that is also
> a multiple of the descriptor size.
> 
> The diagnostic change is to pass the byte-order converted
> len instead of the raw desc->len, so the reported length is
> correct when the vring byte order differs from the CPU byte
> order.
> 
> Would you prefer that I send a v3 on the original v2 thread
> with this diagnostic correction, or should I drop the
> October 21 posting and leave v2 as is?
> 
> Thanks,
> Fang

pls take a look at my tree, vhost branch. if you want any
changes made wrt that, pls let me know.

-- 
MST

