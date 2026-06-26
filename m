Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71810376BE2
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 15:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782486401; cv=none; b=X29p2Bf6zsKS3MPyfDu4d04IkygBDdCGJIxL3JubnGx/IuifX6bPOriOwtWuBUvZzD9IUz0Yx0xeUqYs10bLTiJKvYJKOkmKOFvXtELAMUXn+ye20r2gJmYISW0QjZH+fuzvnmc9cHX1bmA/2z725kMKzYpmfilgpEMkj1ln1+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782486401; c=relaxed/simple;
	bh=WxThccFU6fqH1o7MU/b8IjeGX/MbGDadiHicR6Np6Es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvEr61UZpGWU1bu8z2bSjtB3cRvqJeOxVkNFi/w22KEcLvnruCOOBJjzmNIOIFVIducD0DV2fZEXIwuMqQlMri8o/OsyGXt/1HR5L1ik/brf5xo+9/QfWdqDlh0AywA4ulqWCBoo2U7qBpcnZ1/GR9GQ7cbA+s536sDQo3UUGRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fD/4lAjE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fD/4lAjE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782486395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WxThccFU6fqH1o7MU/b8IjeGX/MbGDadiHicR6Np6Es=;
	b=fD/4lAjEyFtIb9Jk86YObDcdRhliZeqLO2sz1MKVzMQgdK0PD+oaPZ+vr8dU8LuGk794J/
	jZQf6yjuLGzDyQjlwZbPk6/YoSSPgLG80nDZkW6LjC40zWDGiBqqKf4ZeJ9n2JYgd+4RXj
	SQhIyeFrjY8Il/Gi0rcJD20YTSO65cE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-dZPTgASaNzCfbsZgxDOP4Q-1; Fri,
 26 Jun 2026 11:06:31 -0400
X-MC-Unique: dZPTgASaNzCfbsZgxDOP4Q-1
X-Mimecast-MFC-AGG-ID: dZPTgASaNzCfbsZgxDOP4Q_1782486390
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7FC0C1955DD3;
	Fri, 26 Jun 2026 15:06:29 +0000 (UTC)
Received: from fedora (unknown [10.44.33.126])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D9B34180057F;
	Fri, 26 Jun 2026 15:06:24 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 26 Jun 2026 17:06:29 +0200 (CEST)
Date: Fri, 26 Jun 2026 17:06:19 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Bradley Morgan <include@grrlz.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, ebiederm@xmission.com,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Huang <adrianhuang0701@gmail.com>,
	Marco Elver <elver@google.com>,
	Kexin Sun <kexinsun@smail.nju.edu.cn>,
	Thomas Gleixner <tglx@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] signal: avoid shared siginfo namespace rewrites
Message-ID: <aj6Va2nNBZvDJqP5@redhat.com>
References: <20260622164029.11474-1-include@grrlz.net>
 <aj6Ms6uygc1vtySn@redhat.com>
 <FC7EAB84-0845-4DA3-AD43-3B30B47507E5@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FC7EAB84-0845-4DA3-AD43-3B30B47507E5@grrlz.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 06/26, Bradley Morgan wrote:
>
> On June 26, 2026 3:29:07 PM GMT+01:00, Oleg Nesterov <oleg@redhat.com>
> wrote:
> >To avoid the confusion, let me reply to V1 again.
> >
> >Acked-by: Oleg Nesterov <oleg@redhat.com>
> >
> >IIUC Eric is fine with this change too.
> >
> >Andrew, can you take this fix please? We will send more changes on top
> >of it.
>
> Thanks again oleg.
>
> Andrew did reply to V2.

OOPS... where? I didn't get any email from him in this thread...

Oleg.

