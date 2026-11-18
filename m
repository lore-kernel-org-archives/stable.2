Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019433;
	b=DXHoxEwtsJFH/hDiSHWn8ZMPnEljekAc8H7ndLIYb3F8swuL56VZs2G8PX54e8skNrea
	 D2OwkNk3FwJFOm9CFo9gzGn9Z8uiYXSXc474IbwLdR/3862QmChdl7nhkQ3TVJDs+gfqV
	 tC3wKwkCh0RfFwM7LtmnGH8MNbRpruSmSHmdDifuSmffKm0vs9dwEHFCx88N9XDu6U5v0
	 YG7uqzK3zE5wCuN9/8L6stoQF5S6NwcVryuCCjL4BqmHdehAt6FkxepGVBf5SqE+eR0DR
	 +XfJ/tCN32oYdcDPi2XVC+wXjsbVRt+klbo1GbV3Tn/jyUsk47xIvF8b1tE/zzCwt3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019433;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Scanned-By;
	bh=r6qnE+rrPP/+WIwyrf6W7iyVRQaaxGpUn+33m8pv7AQ=;
	b=AGIcOrU6qPJKwucwQVvuy112AVT3JOdRhbLUUQrG82MqCX+Sf86rryv2o7KVdz7O14dN
	 r7QEt7hoSNRAZo6jb7gX4WqgVQzH4MWCiqz+xY4UnmM+R9ZFRuYtDjpuK5XqigHh87Tpl
	 ovU+EWf87Hi/ClHa5T84E5+PLqaVyt1ngGPsUw7PT61+khvpwfStnSJD6KsD7Bfx2NX/g
	 1xVM3BwiD4eW7qDqFVesuJDm99BG6vVC9T2s6H30u574NHyUAI9g50fY9p3/tfbSImP+V
	 wRdnHbKqXSpEMMCUgJ8+qhH41xYVU+G1CKCSMISnnqqnVZKiGaPYMpjXJ37PAX65XQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hI3yErJg;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13349606C3C2
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 16:30:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13349606C3C2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hI3yErJg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795019432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r6qnE+rrPP/+WIwyrf6W7iyVRQaaxGpUn+33m8pv7AQ=;
	b=hI3yErJg7aq2RxIqVxCbgWPcvX9GD7yq2sNP5Rv43oSQvaaZFC+9c8uChdwiEcdbK2RVMa
	ML/StDbsDQb8ImpHusk0g/7YQ3qF2Ak/G3yfzIy3p9IZJyyrtgF1ZAlzLhQ07norjYiOle
	RiHOq1sCLaSJ/Qpi+Pwi6Z0lWlFNH7A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-144-ykpJEus6P_-OoU9HyaJLdg-1; Wed,
 18 Nov 2026 11:30:25 -0500
X-MC-Unique: ykpJEus6P_-OoU9HyaJLdg-1
X-Mimecast-MFC-AGG-ID: ykpJEus6P_-OoU9HyaJLdg_1795019423
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 39B6F1800365;
	Wed, 18 Nov 2026 16:30:22 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D9A5930000E8;
	Wed, 18 Nov 2026 16:30:18 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Wed, 18 Nov 2026 17:30:21 +0100 (CET)
Date: Wed, 18 Nov 2026 17:30:17 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Christian Brauner <brauner@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	tz2294@columbia.edu, stable@vger.kernel.org,
	Mani Tofigh <mt4022@columbia.edu>
Subject: Re: [PATCH] pipe: keep per-write wakeups for EPOLLEXCLUSIVE consumers
Message-ID: <av3SmRMGDLVAwMzK@redhat.com>
References: <20261111-pipe-epollexclusive-wakeup-v1-1-0af6283e9fda@columbia.edu>
 <avxWKI795DthE8Sb@redhat.com>
 <CAHk-=wjOq+G=6gte4vX_YxOD_VfE1uZh7=+KHs8N0wU75xyHEg@mail.gmail.com>
 <avyODoFhZ_M7YDU5@redhat.com>
 <CAHk-=wgcBSBtHE+3ceKGjq1jyF64OyoEqf5JPpixowAa80GqNQ@mail.gmail.com>
 <avyVwg-5ef-pXZkG@redhat.com>
 <CAHk-=wjJF8uZLfVbbqei9-fhs9K70i2OnVreCV-rQF9EGKAxJg@mail.gmail.com>
 <CAHk-=wjqParwoB8wb9KfGVpbwUwvKvObpLOo=XPM0GGfkn3ibw@mail.gmail.com>
 <av2juQijIISJAgyf@redhat.com>
 <CAHk-=wg4RgBYZcUU+c16XxdZ4UbAaazJkUS=R6=tpN4xUBdDRw@mail.gmail.com>
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
In-Reply-To: <CAHk-=wg4RgBYZcUU+c16XxdZ4UbAaazJkUS=R6=tpN4xUBdDRw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 11/18, Linus Torvalds wrote:
>
> Some duplication - with explicit naming of the locking status for the
> special cases that are called with the lock already held - is much
> preferable to dynamically doing the locking

OK, this was my plan B ;) I'll try to make a patch this week.

Oleg.

