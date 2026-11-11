Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794407874;
	b=GgjqeGKku9RS9JlGDpAQUoYeelPXiZXpmd7PVyObYLYk59YBhzxpdYnzKUJBvIKGHJcL
	 TrEU1QQPnmNGPRw9b806ovBuk3Z08pVOVpkulouKgpyGgjdRWafdyw2oT2/2gbSXAZMjd
	 6JfgKTP9Y8oEmSeIA7hGhXIz7yVDZmPRCAw+TrHgiKWZbBuYPbd0JB/rRcdKBp7Kwz1VS
	 ebJFEtAR9DrcNedh+eb0rUuwtIo+jELeegZ3kROzL+uCWUBPDCfN+konUlJWk+3bQA0DO
	 AkSBAQhmpzeEBBqcykyUcpBf9kwCuF5sDAQ1Yv1AmOHZ8Fg8ERJHXnn7UUAJiaVg6aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794407874;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Date:From:To:cc:Subject:
	 In-Reply-To:Message-ID:References:MIME-Version:Content-Type:
	 X-Scanned-By;
	bh=YjZMS/HoDZxdGMSZkUiBHF2BMKQ3PeLlDs9QzYP0098=;
	b=fFdAo14GNmimC3JBxNHrwOsmHPe6IZbY34x/a2Z54+8zKLgWpcVt1dzYfCvVZ4VJlj+I
	 XtI+jqEZ0bWpLedkNuHq2uZJvRJraITxG6mJYR62iBhqVYp6vnDQZ6Ygx3f5TLdFYCF1u
	 wnrw6tHc4qPUHFF+UO5Kku6lYI7Z7kJ+HlUZa6QkgrVdaROBqWXOiSEEkyDkA3VaxjFOE
	 JMWwSXkANWq3DG01eqqVlJdwdIMkf9AjP7MR7teu3EBpR0YiFqtsTEZ9ckl4pHtxko0EH
	 qQbq2xTJiPJ3vMX7/bmGW4sFGbpgKgg3G0sA6uEMbKYZNtQLh78subCV0Aqn4eLqX+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XsA084M+;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C16F606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 14:37:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C16F606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XsA084M+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794407873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YjZMS/HoDZxdGMSZkUiBHF2BMKQ3PeLlDs9QzYP0098=;
	b=XsA084M+l3nYq4/6MkB9ZkrFH7NBA4cbumERdxYFiAuQyIosHEvdV8Ycet33KF7j/V/mYJ
	Roveqi6/Rn90Yw5k5A8+RctxIiYonM18hlszBlAtz3pqPIgsFcmuOo8e3dqp6Toax3r3NZ
	xbLW7yJkyryBNx1zGyc4B+zSsVw6hNI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-a0T2gJqRN3OsZNUfEIZOxg-1; Wed,
 11 Nov 2026 09:37:49 -0500
X-MC-Unique: a0T2gJqRN3OsZNUfEIZOxg-1
X-Mimecast-MFC-AGG-ID: a0T2gJqRN3OsZNUfEIZOxg_1794407868
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 35D7118001DE;
	Wed, 11 Nov 2026 14:37:48 +0000 (UTC)
Received: from mpatocka-thinkpadx1carbongen12.rmtcz.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 798BF1956086;
	Wed, 11 Nov 2026 14:37:46 +0000 (UTC)
Date: Wed, 11 Nov 2026 15:37:44 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Benjamin Marzinski <bmarzins@redhat.com>
cc: Mike Snitzer <snitzer@kernel.org>, dm-devel@lists.linux.dev, 
    syzbot+94dac3c75477e184f0b0@syzkaller.appspotmail.com, 
    stable@vger.kernel.org
Subject: Re: [PATCH] dm-integrity: initialize journal accounting in
 dm_integrity_ctr
In-Reply-To: <20261111004905.1047753-1-bmarzins@redhat.com>
Message-ID: <6200b697-d686-cff2-1de5-d4948c171a4f@redhat.com>
References: <20261111004905.1047753-1-bmarzins@redhat.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17



On Tue, 10 Nov 2026, Benjamin Marzinski wrote:

> If the superblock for a dm-integrity device is changed while the device
> is suspended, it will resume in a failed state, and skip
> replay_journal(). If this happens on a journaled dm-integriry table's
> first resume, replay_journal() will have never been called, and the
> journal will be uninitialized. While nothing can write to the device in
> this state, integrity_commit() will be called if it receives a flush
> request as well as on suspend. Even through there is nothing to commit,
> pad_uncommitted() will check that the journal accounting is sane. This
> triggers a kernel warning because the accounting was never set up by
> replay_journal(). Fix this by setting free_sectors equal to
> journal_entries. Since all the accounting variables are zeroed when
> creating the ic structure, setting free_sectors is all that's necessary
> to mimic a cleared journal.
> 
> Reported-by: syzbot+94dac3c75477e184f0b0@syzkaller.appspotmail.com
> Closes: https://syzbot.org/bug?extid=94dac3c75477e184f0b0
> Fixes: fc79aeb86a2c ("dm-integrity: validate the superblock on resume")
> Cc: stable@vger.kernel.org
> Signed-off-by: Benjamin Marzinski <bmarzins@redhat.com>
> ---
>  drivers/md/dm-integrity.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
> index 1659a11a1a29..419a8b958371 100644
> --- a/drivers/md/dm-integrity.c
> +++ b/drivers/md/dm-integrity.c
> @@ -5430,6 +5430,12 @@ static int dm_integrity_ctr(struct dm_target *ti, unsigned int argc, char **argv
>  		if (r)
>  			goto bad;
>  
> +		/*
> +		 * initialize journal accounting like a cleared journal, to
> +		 * handle a changed superblock on resume, where the journal
> +		 * is not replayed.
> +		 */
> +		ic->free_sectors = ic->journal_entries;
>  	}
>  
>  	if (ic->mode == 'B') {
> -- 
> 2.56.0

Hi

I think that we shouldn't attempt to flush the journal at all when the 
device is in erroneous state - because flushing it could cause other 
problems.

I've created a patch that disables journal flushing if the dm-integrity 
device is disabled due to an error - please review it.

Mikulas

