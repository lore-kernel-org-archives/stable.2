Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D6B3AF66E
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 15:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784390326; cv=none; b=WbFoC/fXYvAUWLhAUmqeI9GTQUM3IB8FKunpVu8Fm9cAYpK/CMrglIn+NCP5rBgrCTfWI/q8j3TgR/o51cgP+1UFrFoq8J71wk1k/JkXDcVpp92eJq1Qh/HO+GVpMQCMGy9Dk8d5LsHN5+9u9EwxbWCkWN9NSaEMtD2orpaQbEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784390326; c=relaxed/simple;
	bh=PvN2HLQhAaLXlpOHHhZweNIus4j78PSrfxzg2sCiE4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RtzPfSjpxUZYKGFsUPVKB0rCskbOZhyEnQh1xU/nYb6IT2fMtWwAgObPyAGatm3VI+7sqHU+k94YKFjaD36A7INjG6DZy/vrMX3qX2ffUjkfRmr3c5Uvmd/jKiXxAwsX5Pu2hvOkapT8K01SIQRkooXs4qMdLILdQFHlVS3I80k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LjpKh1XO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LjpKh1XO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784390311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RcAQ6taD/yyIt8Pb998GX64Zj0fY5Baff1M2jYSbUn8=;
	b=LjpKh1XOAaKpnYO+JREI0ovbai97U/YDzMnOIoZxca9Es0MEG7VeRRKpSnOFfdqc/or8xg
	NlMKnF3QGAoksxCSlfUtLKmzOkYFeGUuGE1LN1zZlC1G6HNJ52nfOILwoQghd16+lEpmgW
	55g2R8rLRHDNO9oPa3eqyZx+Gqz0oOs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-382-FdS8r3tpNqSKldJhCvw1Yw-1; Sat,
 18 Jul 2026 11:58:28 -0400
X-MC-Unique: FdS8r3tpNqSKldJhCvw1Yw-1
X-Mimecast-MFC-AGG-ID: FdS8r3tpNqSKldJhCvw1Yw_1784390306
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 85C6C195D031;
	Sat, 18 Jul 2026 15:58:25 +0000 (UTC)
Received: from fedora (unknown [10.44.49.164])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 95F3A300418A;
	Sat, 18 Jul 2026 15:58:20 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat, 18 Jul 2026 17:58:25 +0200 (CEST)
Date: Sat, 18 Jul 2026 17:58:19 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>, brauner@kernel.org,
	akpm@linux-foundation.org, jack@suse.cz, avagin@gmail.com,
	ptikhomirov@virtuozzo.com, include@grrlz.net,
	linux-kernel@vger.kernel.org, AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com, kys@microsoft.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] pid: fix cad_pid use-after-free race
Message-ID: <aluim8REjBcE4ejB@redhat.com>
References: <20260718032000.9184-1-blbllhy@gmail.com>
 <20260718032000.9184-2-blbllhy@gmail.com>
 <alt9fbrO1WlJg-Jh@redhat.com>
 <CAGudoHEMhAfDf8c0P89yEkaVgC6c=Q822-6OFzgG82v+SHvkvA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHEMhAfDf8c0P89yEkaVgC6c=Q822-6OFzgG82v+SHvkvA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 07/18, Mateusz Guzik wrote:
>
> On Sat, Jul 18, 2026 at 3:20 PM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > On 07/17, Cen Zhang (Microsoft) wrote:
> > >
> > >  int kill_cad_pid(int sig, int priv)
> > >  {
> > > -     return kill_pid(cad_pid, sig, priv);
> > > +     struct pid *pid;
> > > +     int ret;
> > > +
> > > +     rcu_read_lock();
> > > +     pid = get_pid(rcu_dereference(cad_pid));
> > > +     rcu_read_unlock();
> > > +
> > > +     ret = kill_pid(pid, sig, priv);
> > > +     put_pid(pid);
> >
> > Hmm. Why do we need get/put_pid() ? I think that
> >
> >         rcu_read_lock();
> >         ret = kill_pid(rcu_dereference(cad_pid), sig, priv);
> >         rcu_read_unlock();
> >
> >         return ret;
> >
> > should work just fine?
> >
>
> I suggested taking the ref as a future-proofing measure to *not*
> impose any requirements on kill_pid.
>
> Admittedly when responding to v1 I blindly assumed pid is always
> rcu-freed, my bad.
>
> Given the arcane nature of the proc file at hand and 0 performance
> concerns, I think the easiest way out is to give it a spinlock to
> protect access to cad_pid as opposed to trying to play any rcu and
> lockless games.

Just in case, I am fine either way. I'd personaly prefer to play rcu
games in this case, but I won't insist.

I've sent my comment only because get_pid + put_pid + kill_pid() outside
of rcu_read_lock() look really confusing to me.

As for requirements on kill_pid... See for example kill_pid_info().
kill_pid/kill_pid_info/etc are all rcu safe wrt "struct pid *pid" arg.

Oleg.

