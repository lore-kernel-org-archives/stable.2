Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414504;
	b=yBLhZU5W85ot73j2t+wEPDvJDJEQYGy+dmbTD2Zz9amnxku0ncGYD+ghr44p98B6jNHS
	 c0J21czUkTiKbkfzYWq8LVNk3zS/lnpiS0iWlZGaD/FSGN06a9wwhv0bSfJ1t9Yf+xvNa
	 dkOqxtcVkvpSmCIkYuJOoGeCDsZiVMroDR1EEqcaIw3gS/vxASjWivYa7wljdB/8ZnH+b
	 XzWkRWuOZ0aryjXVryUW2iYcKvzz98zh5uWxXppNC83+3botcyCrJHD15xU1uiU20Djpt
	 tS7Cpo5jedpUYAmw+hdGqaFKxMl8Xf/3GBtz5CK87lJyKf33M6cAupSKdS72HclgnFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414504;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Scanned-By;
	bh=gvj4xIltj42d86arrpfwUC1RgAIG12UQS/T56hQYxjE=;
	b=GPm8ljo3G2oIH6d01LzgqetExCU6wsagIzas/KsWzAZA/uZlrBKxgztDYMBhmzjG+NDo
	 OF77PaZ3QFdCpqWA3shz54aSmkJcBWHKA4ij35cz4s48E4reH3+rYK1Vi2OhgLAGiE01C
	 5JV4Rj+kyY2oXXd2kVBblagfvq30VmpGngkCH8SwZPYrk7X8h2/HslB+06XylwLVSFfCx
	 g+mRZME+5vpb0WLXAKCSj1qkFq+3kne1TZDwD4oLm1ieCkvxKbQXOr31gvbQqclFPKBHr
	 WVVLzG2MSwjusIWB2teVXX9tpbH+wprceMDX1yhZzFZL0gpUoUgftcviaHN30s3j29g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="CiHj/l5V";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2E6606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:28:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E2E6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CiHj/l5V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794414503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gvj4xIltj42d86arrpfwUC1RgAIG12UQS/T56hQYxjE=;
	b=CiHj/l5V0BwcpYjqr7LiO9h61AY1LgJ0GRgRL7jq+j0FqJ4jV0FrzeQ0eUnmjCudr0+Dhc
	YaJHjCs+OR5o1C1+YLMDLqHQn6iyLbX4jHuCYSuSFGpyxtcWg0utSkYfs/08ih97EOwEC6
	GExJx3+wgOVSyZOqilH67aAWpgQrQXs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-J7vunRmPOlWvNyTTHqqtdw-1; Wed,
 11 Nov 2026 11:28:20 -0500
X-MC-Unique: J7vunRmPOlWvNyTTHqqtdw-1
X-Mimecast-MFC-AGG-ID: J7vunRmPOlWvNyTTHqqtdw_1794414499
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C08581977406;
	Wed, 11 Nov 2026 16:28:18 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (bmarzins-01.fast.eng.rdu2.dc.redhat.com [10.6.23.12])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 32CFD18004FC;
	Wed, 11 Nov 2026 16:28:17 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 6ABGSGwB1287382
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 11:28:17 -0500
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 6ABGSGp11287381;
	Wed, 11 Nov 2026 11:28:16 -0500
Date: Wed, 11 Nov 2026 11:28:16 -0500
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>, dm-devel@lists.linux.dev,
        syzbot+94dac3c75477e184f0b0@syzkaller.appspotmail.com,
        stable@vger.kernel.org
Subject: Re: [PATCH] dm-integrity: initialize journal accounting in
 dm_integrity_ctr
Message-ID: <avSXoMubUuU6kiR5@redhat.com>
References: <20261111004905.1047753-1-bmarzins@redhat.com>
 <6200b697-d686-cff2-1de5-d4948c171a4f@redhat.com>
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
In-Reply-To: <6200b697-d686-cff2-1de5-d4948c171a4f@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Wed, Nov 11, 2026 at 03:37:44PM +0100, Mikulas Patocka wrote:
> 
> 
> On Tue, 10 Nov 2026, Benjamin Marzinski wrote:
> 
> > If the superblock for a dm-integrity device is changed while the device
> > is suspended, it will resume in a failed state, and skip
> > replay_journal(). If this happens on a journaled dm-integriry table's
> > first resume, replay_journal() will have never been called, and the
> > journal will be uninitialized. While nothing can write to the device in
> > this state, integrity_commit() will be called if it receives a flush
> > request as well as on suspend. Even through there is nothing to commit,
> > pad_uncommitted() will check that the journal accounting is sane. This
> > triggers a kernel warning because the accounting was never set up by
> > replay_journal(). Fix this by setting free_sectors equal to
> > journal_entries. Since all the accounting variables are zeroed when
> > creating the ic structure, setting free_sectors is all that's necessary
> > to mimic a cleared journal.
> > 
> > Reported-by: syzbot+94dac3c75477e184f0b0@syzkaller.appspotmail.com
> > Closes: https://syzbot.org/bug?extid=94dac3c75477e184f0b0
> > Fixes: fc79aeb86a2c ("dm-integrity: validate the superblock on resume")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Benjamin Marzinski <bmarzins@redhat.com>
> > ---
> >  drivers/md/dm-integrity.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
> > index 1659a11a1a29..419a8b958371 100644
> > --- a/drivers/md/dm-integrity.c
> > +++ b/drivers/md/dm-integrity.c
> > @@ -5430,6 +5430,12 @@ static int dm_integrity_ctr(struct dm_target *ti, unsigned int argc, char **argv
> >  		if (r)
> >  			goto bad;
> >  
> > +		/*
> > +		 * initialize journal accounting like a cleared journal, to
> > +		 * handle a changed superblock on resume, where the journal
> > +		 * is not replayed.
> > +		 */
> > +		ic->free_sectors = ic->journal_entries;
> >  	}
> >  
> >  	if (ic->mode == 'B') {
> > -- 
> > 2.56.0
> 
> Hi
> 
> I think that we shouldn't attempt to flush the journal at all when the 
> device is in erroneous state - because flushing it could cause other 
> problems.
> 
> I've created a patch that disables journal flushing if the dm-integrity 
> device is disabled due to an error - please review it.

I was on the fence about doing something similar to your method. It does
drop any previous journal writes to the partially filled uncommitted
section, which is a bigger change than just fixing a kernel warning. But
that's the way you think we should go, I'm fine with that.

The way I planned to solve it was (copy-pasted so the whitespace is all
messed up):

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c              
index 1659a11a1a29..bf817c5ce2b3 100644                                         
--- a/drivers/md/dm-integrity.c                                                 
+++ b/drivers/md/dm-integrity.c                                                 
@@ -2908,7 +2908,7 @@ static void integrity_commit(struct work_struct *w)       
                                                                                
        spin_lock_irq(&ic->endio_wait.lock);                                    
        flushes = bio_list_get(&ic->flush_bio_list);                            
-       if (unlikely(ic->mode != 'J')) {                                        
+       if (unlikely(ic->mode != 'J' || dm_integrity_failed(ic))) {             
                spin_unlock_irq(&ic->endio_wait.lock);                          
                dm_integrity_flush_buffers(ic, true);                           
                goto release_flush_bios;                                        

Even if we don't call dm_integrity_flush_buffers(), any dirty dm_bufio
buffers still still get written out. By calling
dm_integrity_flush_buffers(), we control when they get written out,
and we want to guarantee that they get written out before we suspend.
right?

-Ben

> Mikulas

