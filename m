Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AB63C3792
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788700879; cv=none; b=ukHCZPlmmEsfMjLvX1ZxOgLnPHt3csSPEZuIFMtDZhmnuZYAUCW8mDI+MWLGv1cL09GHOWxv1Lnupz4Y/ES7y2gbStztoLs96yUAA2VN+LWMZ8i+oI9O6tf+Z4KZ3xS4y/QqoPJii+x13+pa2K5pses0QfE7PvE97LQUWXU5O0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788700879; c=relaxed/simple;
	bh=alPKOn5jAxNKbM1bj3uVT9M8gY6+O/RJ1mvuAo8YnZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBTvqDsl1q6YqYZlVAYoiGkHTkG7vC/EFYwUEcq0zqhYZjIeZfeqgQFWAM/EP/saacnGsY7ZLkvZBMp2Sw+6ntJU6Wsyop401qD4NzP3bLm4j6agQHhEE9hrJiYJ3sRx8TpaAPxG42iykwiv6MPfxrIMEJbXohoYSeFFVyID8sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PzGRNWkb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PzGRNWkb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788700876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=alPKOn5jAxNKbM1bj3uVT9M8gY6+O/RJ1mvuAo8YnZ4=;
	b=PzGRNWkbHvSlu4O+6eM0iDV0PTAalzdB4pjY1AEmqZRVhxXOXGYbOChcOUslJhwZv1ugXx
	BqMJ6cqyBob/qC9EcP67eq61lVAzCsJjt72zlRhF6nF3ZHf4FCwceZqaQGv0MzeB7JWHgL
	3lrvCsRBRC1UdbZQSMCbk+GtZQwY6S4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-158-Xz_C8Gk5OZ-LrqpUjLBUOg-1; Sun,
 06 Sep 2026 09:21:11 -0400
X-MC-Unique: Xz_C8Gk5OZ-LrqpUjLBUOg-1
X-Mimecast-MFC-AGG-ID: Xz_C8Gk5OZ-LrqpUjLBUOg_1788700869
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 809BB1955F21;
	Sun,  6 Sep 2026 13:21:08 +0000 (UTC)
Received: from fedora (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 2442A1955F05;
	Sun,  6 Sep 2026 13:21:04 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  6 Sep 2026 15:21:08 +0200 (CEST)
Date: Sun, 6 Sep 2026 15:21:03 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Cc: Hyunwoo Kim" <imv4bel@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"Eric W. Biederman" <ebiederm@xmission.com>, stable@vger.kernel.org
Subject: Re: [patch V2 2/8] exec: Cleanup POSIX timers right after de_thread()
Message-ID: <ap1ov3-KS_y9NVcc@redhat.com>
References: <20260905181551.738186850@kernel.org>
 <20260905185839.716693014@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260905185839.716693014@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 09/05, Thomas Gleixner wrote:
>
> Move the POSIX timer cleanup right after de_thread() before any of the
> later failure conditions brings the task into do_exit().

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

