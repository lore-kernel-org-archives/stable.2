Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20B0382F25
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 20:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783022968; cv=none; b=a1B4ftZAfjK6g4qYXcG7Qp1fBvnbwYe8NHII8iT/MOsqKj41n/CojW6Zj8OAS0lbQ/qleZ0oaAPTFNJ0zMW1k+0a14w/i3XrBjL9CwLLY2b60HQZHG0KZ/4nwVYGXUNDIYGb639srTSbs78lQ1R0latLmio+1OIsmlBL4hBN6UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783022968; c=relaxed/simple;
	bh=13oD+YiL/3o0MEN6K6Y/bx7CKvJzT37nBrfnC/MzHFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fchkX4jo4ParU5mO8lqGSOBQ+gmfg8xcknEs8kVdByALoDUVawZMKQ2zYxIRjSEWJoUxafnbNNLOs7f51bmn4DkFTBB2cUtIcctxobCYh+6Tyw3hQaoieVkYN2fhwGu2pMDGJeZ9Ltm6+qKXtbFp/YK4zck93XqcdKT3JMJWyxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qYht2Prb; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qYht2Prb"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6a2c1edb210so861698eaf.3
        for <stable@vger.kernel.org>; Thu, 02 Jul 2026 13:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783022965; x=1783627765; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WjQFRK3eyEfNEKRH/kJEfHrxEWDAZH2cdSABwq7lLiA=;
        b=qYht2Prb/gnqRafc370x8QL0AVhwNbkWYD7Mb0oEnS6BBC1/7zqQk4okOm+qy8WkGQ
         RxC4dqTCKz01d3diR6dB2/5uKwM8YFAPrXjCx646oRPimx2pQb0+QSMqzy5/ttykB3zo
         tiInWqtjwp7x2BlEhBNZ9UvRPSorkfoZSFL1Ts+hgBxNBzh41kxabF+GJSxtH3TgtrIk
         7bjozptJEY/oUZlHpoUIs2DKPTQ/Ar+ULai3UQ1k3whzj32T+2lzBGKODMkUxIp2ESkk
         Qtocv5xq1OwB5kxkbsoWaRMzaYj74+ddVix6bjxov7mWczXJPVfYTRRDp4sNwrq/6I06
         eXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783022965; x=1783627765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WjQFRK3eyEfNEKRH/kJEfHrxEWDAZH2cdSABwq7lLiA=;
        b=phhv8XfVHETy1aBN+4BgtY1AvCsuXyymr2XBb0lGPlu6Mu9EKLgliErNfXHUgTQrIM
         kekka6cLQG2MZtlCMFCA6pXqZBQUKa4bYRqFAJ6p1bRh70cYkTBHY9luTruwmZTjeznJ
         hlEOp3EHi0GROfjrsEayCAkXdVDmDbj5Oj5SUH0bd8IP0aJZ9k1jDLcSFyfL7SpnGYrr
         Q2dNSXndP0yIhZko3Y4X0gE3Haem17QxXhx2keacbNdkgpBCyEVJaNen+02U86v9v5Hr
         1GSsZWEv5O6BPsgVBcNHbZuUKVLGc/kaxQ+w3D2BxFBnHtp2xBZjJ5ylB3ZC10TJByq/
         ghAQ==
X-Forwarded-Encrypted: i=1; AFNElJ+YoQa+ck98u9xl9OCaYlqOkXQiRN+g3eTaTvgZYF5pEkPndlTZ+DdubuAPeF0BD7JL6I7HTR8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2TshfdSvtpwjMJs9ZlIqPkSmxwLmdhXjcpt14MLVH2c0F/1Rw
	xJKnwD1GzvOOxxWcgFtJ9QhH6rQ05EqcqyJBWkgwkd0BBKNAY62cgSYG
X-Gm-Gg: AfdE7cn6xE/DeBjlZouR/P+kKy4gZsbaEhw27hJm7oXaWSnNC0+GGSv0kDKkS7tR8zz
	9UVyPZS0nVvSjA2mZuzG8mMN0Y2GDSr92ztzP4w0zRe4MTowqRT8HGyZjMbGh2gjgypT3ZsCPBz
	umMRzJoy4wS28DlnJRA+OroytV2B6CvtDEj3HiSFvmIgr2TOw03shO9R4chaaGfg4YIQi6PBZNk
	GLV6zlnwdJ491m5GyokHilYK5rRE4rsV6l7qphdg02ufXWubfQX3hdMlHswb3YA5URmr97TyP8r
	oF6B/nu75JZWlOETemwb0SqqCRGCxHX0PAEKm6VkbpAYqlxx/IQGQnRTPaElD6RI/nVoWMp/oCf
	5bY7bWmJRLLK4AP+sKxeqU6pOrWl3lSQiOSbtS5xfUxKgA1O7f/Vi0MsdebIUCmRhlEJ6sntIoY
	jbC7Ea6p2BxZOzPRNgLZx67147FI/E4rODNw==
X-Received: by 2002:a05:6820:4cc3:b0:6a2:739a:ce95 with SMTP id 006d021491bc7-6a309929b99mr4607337eaf.4.1783022964709;
        Thu, 02 Jul 2026 13:09:24 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:43::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44cbec93702sm3662142fac.12.2026.07.02.13.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 13:09:23 -0700 (PDT)
Date: Thu, 2 Jul 2026 13:09:20 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	stable@vger.kernel.org, Brien Oberstein <brienpub@gmail.com>
Subject: Re: [PATCH net 1/2] vsock/virtio: collapse receive queue under
 memory pressure
Message-ID: <akbFcMHenseQW7mJ@devvm29614.prn0.facebook.com>
References: <20260626134823.206676-1-sgarzare@redhat.com>
 <20260626134823.206676-2-sgarzare@redhat.com>
 <akVBmydgSd0Eb46/@devvm29614.prn0.facebook.com>
 <akYl38_9Y4ydXuqE@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akYl38_9Y4ydXuqE@sgarzare-redhat>

On Thu, Jul 02, 2026 at 10:56:04AM +0200, Stefano Garzarella wrote:
> On Wed, Jul 01, 2026 at 09:34:35AM -0700, Bobby Eshleman wrote:
> > On Fri, Jun 26, 2026 at 03:48:22PM +0200, Stefano Garzarella wrote:
> 
> [...]
> 
> > > +out:
> > > +	if (new_skb)
> > > +		__skb_queue_tail(&new_queue, new_skb);
> > > +
> > > +	skb_queue_splice(&new_queue, &vvs->rx_queue);
> > 
> > I think the new skbs will also need skb_set_owner_sk_safe(skb, sk)
> > when adding to rx_queue?
> 
> IIRC we added it in the rx path, mainily for loopback to pass the ownership
> from the tx socket to the rx socket, but here we are already in the rx path,
> so the skb will never leave this socket.
> 

Ah that's right, I stand corrected. There is no sender to leak in this
case.

> Maybe it's necessary for the eBPF path?

Looking through sockmap, I don't think it depends on skb->sk being
non-null either (it reassigns owner to the redirect socket anyway using
skb_set_owner_r()).

Sorry for the false alarm. LGTM.

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
