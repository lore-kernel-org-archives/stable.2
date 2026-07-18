Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48FC3176E0
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 13:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784380813; cv=none; b=Ll9A7zVxie8fkBTiHmWrRHk+YtcOr9yEFVCmoJhunqGx2qVKwasNRGzZ/+bJfRTrkuGMsSzGwN2RIdr6hJbFjE1i2/gs2/S1a++UisHKpMhKjE62f+Pgv9fWqbJ3gT42itrnCduO6scLko4awWcCVr4OknxPpcHyjUKLcZfK44w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784380813; c=relaxed/simple;
	bh=JO8+iWyhyJYzxq2F8YcIKhtX0Q1fEBvhWuaDUb8mtDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JfQ3+Keyy/p63Xkx/KblTufY9KtGGttd2lOOaA4tJ4l0NydelgIZdU0CqWfHZ9CE/QT3A9TJlq6nyM/GtKjL0ZL0dUEYGK0/7e44YtjG0GQT+ufO1IQXpmOrGHdTGek4iLgDwzhlRVLlRiLv3bPEf3NtFXYyZqde08KwdtzD5YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q+++WiER; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q+++WiER"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784380810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fOYcSzcWll4uu/tFlZVx9l9q5Vx2+2qfb3L35RcSZS0=;
	b=Q+++WiERq3CXoqAn0aOLbb3aQJQz+4R70QCLwobPjlMg4/a3LTvB+yK/LLB0O2SSYsRk1G
	zbZ+VHmT7lDx5DdqPcK3H5N59Cofy2fk1vr4N5qTpe10VPwUNUWUEq654VuIu8E1G/xwG8
	s+TrFZdqXHdBHP/gXVHW96D2T/5Suu0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-247-PLok7FhONzWn7HYYf9BJlw-1; Sat,
 18 Jul 2026 09:20:07 -0400
X-MC-Unique: PLok7FhONzWn7HYYf9BJlw-1
X-Mimecast-MFC-AGG-ID: PLok7FhONzWn7HYYf9BJlw_1784380805
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C5B7F1800EF3;
	Sat, 18 Jul 2026 13:20:03 +0000 (UTC)
Received: from fedora (unknown [10.44.49.164])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D5FBD1800263;
	Sat, 18 Jul 2026 13:19:58 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat, 18 Jul 2026 15:20:03 +0200 (CEST)
Date: Sat, 18 Jul 2026 15:19:57 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
Cc: brauner@kernel.org, akpm@linux-foundation.org, jack@suse.cz,
	avagin@gmail.com, ptikhomirov@virtuozzo.com, mjguzik@gmail.com,
	include@grrlz.net, linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com,
	kys@microsoft.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] pid: fix cad_pid use-after-free race
Message-ID: <alt9fbrO1WlJg-Jh@redhat.com>
References: <20260718032000.9184-1-blbllhy@gmail.com>
 <20260718032000.9184-2-blbllhy@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260718032000.9184-2-blbllhy@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 07/17, Cen Zhang (Microsoft) wrote:
>
>  int kill_cad_pid(int sig, int priv)
>  {
> -	return kill_pid(cad_pid, sig, priv);
> +	struct pid *pid;
> +	int ret;
> +
> +	rcu_read_lock();
> +	pid = get_pid(rcu_dereference(cad_pid));
> +	rcu_read_unlock();
> +
> +	ret = kill_pid(pid, sig, priv);
> +	put_pid(pid);

Hmm. Why do we need get/put_pid() ? I think that

	rcu_read_lock();
	ret = kill_pid(rcu_dereference(cad_pid), sig, priv);
	rcu_read_unlock();

	return ret;

should work just fine?

Oleg.

