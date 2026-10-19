Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B754A33F5
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 08:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399820; cv=none; b=QfD6LsTP0m0vMUTANY8vYQ+6MI+K7cTck67QHDj6pjqx4xYGJGRbxBQOgBqWEYZ5sTbx0Q81cZ+l/a5DEFSh/8zEzm0umUcNkCY9wgVBSELBjXWc8yBRJut8XMqbxXGSyevH0OQiPXzAKI5UgilRPe3iu3RAzuBvlm6zNeTiuIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399820; c=relaxed/simple;
	bh=gLEdQXnX/NH4vv8bqP1oy5+vIMvsVWW1qJLPjJD3Hqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2KbFFogkaa+jbu7yYPl8HXxVLZZ43dLT4j4JinntOYODJIl+KfYc+YhZqtYblO8H6S7v4YO6aOQxbEKUgYa5Wh8ue8IaiqNYOwqS41Hc8cAHHPAOuHdX9LXRhgjI4IKmm3UoQEucvTqJ9ApkRK4+NNJHDavZAKkvU3hpc4Xnq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SRvZ8n/Q; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YX53418x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SRvZ8n/Q";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YX53418x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792399817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=55qXrjAuKib4u3E08BN5EfqZqO/u7NoV8YCWXaz8QW4=;
	b=SRvZ8n/Q4Z0e5Rps/MQyaAt5pkNkLj+U0vahENIkDqOqulwHQnb3rqVmliwBHy1faebVHO
	Y9yP0T0aqKrx9/EUHiN97GHXMfBiBhDfrKBLqkmKYQgRPigO25nzMw9lLxnc3NOePNJcYy
	rlIzet0lZ7K7yhGu8Yhfr3Y2fWk1ya4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-C6OHVzb-Om6osYHihVpa5A-1; Mon, 19 Oct 2026 08:50:16 +0000
X-MC-Unique: C6OHVzb-Om6osYHihVpa5A-1
X-Mimecast-MFC-AGG-ID: C6OHVzb-Om6osYHihVpa5A_1792399815
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-486f9d150c3so930128f8f.3
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 01:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792399815; x=1793004615; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=55qXrjAuKib4u3E08BN5EfqZqO/u7NoV8YCWXaz8QW4=;
        b=YX53418xhsqa9xEIi3zqaC3NvR2LB5Trm059XESwfel0J7E6Dw4N/4tGLqqaaMVtc5
         0LG26nm+1d+7KCqOmj766yF4vJAzwOxm92QE6K4UZgQqpcqK6TJWwMyQkOUsleTCjzsw
         jI0QiZovEqPh64yN4CBAxvb0PZeOVo2mvFLDC9qvBfnWDXfk8m+4iUNoa9L3Bo66vMkA
         GuSt4yqGymhgLyMB68yLx2JliYxt7U7MV1g9V5I+ExUFgxPVxvaEi3gNNK0g+bigWKrU
         jDuaoPvdRSB1yq6yXe8ucwjFbRXovEbsFs4oQaTKA9uESXhTB4TLcJ/AqoAkumnDHXo6
         oIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792399815; x=1793004615;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=55qXrjAuKib4u3E08BN5EfqZqO/u7NoV8YCWXaz8QW4=;
        b=kfKAYhMSZkjgHZlmpX+h5LznB8MpVTsUvffBcnqLiEIyYXb5n0CmOj9M/0FPOWtBt9
         ONGKxWqFToZLwrYwIL/0TANDLAS2xFaI23FpVi03S6Sae8TqeX/gwdRvv8PMQPg4wYz/
         4ig9nCrDwWMv657J2DaZG7pLcV0Q/wprSlUDqzU8sURv3KEbdzlVmlrm/tWxtFQySjc6
         TxCLMjy6vMNWmDYLwrn8JZiO+RAv7NCjlvafV+037yLtRH1KzJYG4v0SBLrrn6fohvkp
         MXIGvjSaOPboY4xmBnPhfm3MsNwEBx/1lgbYO+SazfTTPCirO4FkO+VXfEe40f7Bkjmd
         TrSg==
X-Forwarded-Encrypted: i=1; AKwUvBwSjOHrK52ZPk5LTHZeF5OnmZqcqo0KIMsgZLK9Lv56DYRNqrxRaC80K5/+ZdAgpKwn6tCVvIc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIKA0miZdcs9VNEUdpMET1457AhW7V8XNqfjTSprXMnfq+BcASZ
	haYwL5kAYD9WWx1SIWO1+m+WpBDpZAAL51a9IdyU7VFEksOZA95kPmZKayK40agjjYB2JjJ+l3o
	W+BOD5ItV+eZuNGd3ukT9AFzj1AcxmwoS/wAhNS2OR6vMC2tAh97HZ3W4hA==
X-Gm-Gg: AYBFou08D9RmC2QZgij5f/4S/mGL/Jx1CV6pgw+CkjqeOJt38kfKpagN3aWS+Em+akd
	OGhtF9ARNWhep+mFmc5nehvWYQY3LqDEWK1wkTMuJD5gb8UfhIRWIq+BFqA8MC7kZ8Yn8VhSULn
	2OTmGqnwYHeMuGHrnPrhjA/WCYWvHHm7TokpyJGSBHQ5tqyvcEQPuyJ5pYmLBUa54158+KqwhFD
	0mTnbew7LspY8+qGO/rp7s0ZWuJ15ZtzDrNOfw/r3mFJCDVBeKNihmPSbKZboipG5F/ZYE6NRyc
	8VxeLhJZsfMrHuKvJ5h+OxojAIqSXNq0GwHRu6kBkc6mUcKjDnfnCiaqg1tPH0K82u+BIw==
X-Received: by 2002:a05:600c:3b1c:b0:4a1:71e5:9420 with SMTP id 5b1f17b1804b1-4a1d75f9857mr147802975e9.13.1792399815024;
        Mon, 19 Oct 2026 01:50:15 -0700 (PDT)
X-Received: by 2002:a05:600c:3b1c:b0:4a1:71e5:9420 with SMTP id 5b1f17b1804b1-4a1d75f9857mr147802525e9.13.1792399814537;
        Mon, 19 Oct 2026 01:50:14 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1df370381sm105692345e9.1.2026.10.19.01.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 01:50:13 -0700 (PDT)
Date: Mon, 19 Oct 2026 04:50:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Pranjal Kumar Singh <pranjalksingh92@gmail.com>
Cc: cve@kernel.org, netdev <netdev@vger.kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Paulos Yibelo <habte.yibelo@gmail.com>,
	openvswitch <dev@openvswitch.org>, stable@vger.kernel.org,
	"fw@strlen.de" <fw@strlen.de>
Subject: Re: Kernel bug report: unguarded deferred skb_checksum_help() writes
 corrupt the previously-validated IPv6 fixed header (IPv6 counterpart of
 commit 6785011f8b16, "ipv4: validate checksum_start before completing
 checksum")
Message-ID: <20261019044815-mutt-send-email-mst@kernel.org>
References: <CA+UYBZDMpqq989aWq318+T2j4+PU7giVpO8ZffrkDFwqaoKjJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+UYBZDMpqq989aWq318+T2j4+PU7giVpO8ZffrkDFwqaoKjJw@mail.gmail.com>

On Mon, Oct 19, 2026 at 02:13:04PM +0530, Pranjal Kumar Singh wrote:
> Hello Security Team,
> 
> The IPv4 part of this was fixed some time ago in commit 6785011f8b16
> ("ipv4: validate checksum_start before completing checksum"): a packet
> whose virtio_net_hdr csum metadata points its checksum start inside the
> IP header makes skb_checksum_help() (the deferred csum completion)
> rewrite the header the stack has already validated (fixed checksum
> offset-width write at csum_start + csum_offset).  The IPv6 paths were
> not covered, and they still are not: a 2-patch series mirroring that
> commit for IPv4->IPv6, including its remaining not-yet-IPv6-guarded
> sinks, is reproduced below and attached as patches/0001 and 0002.

Thanks, I think this has been reported already. Just to clarify, the effect
is just packet header corruption past validation, right?

See [PATCH net-next v2 0/7] more virtio-net csum hardening
for WIP fixes.

-- 
MST

