Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C44431813A
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 18:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786730629; cv=none; b=DAGSfdFoJtxqUtgT/Vcs8YB9W3/F8oNvo9h43LVTzoDd4DQGbZ+KhRXr3hALrI8Q/E5vi63HzDHi9sQJjCiG4JGgX19ZAZmGx8cE2PLmQ+HiKe6cjwcCyLvqhtwIi9ysqqAgR0Xa9+Mzd6zQ99Y+sTH8rkoot+wgryjt+cPHg6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786730629; c=relaxed/simple;
	bh=MHcf0h1jdj+yq7jbMQVJMENFfR7ve4IWOyG1p7JDbEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RFE1Nr71Is2IQwHJcEkzUsP3CKYquMcNJP7mADFb4annp9TfpNCzsix3fNp6onphc4ww91bkv6YVLx04FyR46wWyABxrtDFrIN6TXBAnYK/p/lyNLeiJybYx701E7kFo7fcOZ7p7iqpNFwsEPYi0zkuBxJKN8jrsSmOTZqo8LOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=da1vrViH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="da1vrViH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786730627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=edsu6JjTslrS34Fvloj+0+8/jlXFMGCx8PgXRPDwZjg=;
	b=da1vrViHSP23VY9elFM1k20hSl9Z+WiP9hwIWt5zqkOwi/8i9xqYRl/ndHowjSldV2dW4D
	NX7slIwd8vYrqUdQAYw9TNT5vflSqvVsvU0s/C0TF5IcewXWSKfESkQH5QYRIIyvSzX+Ns
	1MoeYCETDuypdRBhhPLhiG+apqGWKdE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-575-MroS2QNnPgSGJQeO6ZoXTg-1; Fri,
 14 Aug 2026 14:03:33 -0400
X-MC-Unique: MroS2QNnPgSGJQeO6ZoXTg-1
X-Mimecast-MFC-AGG-ID: MroS2QNnPgSGJQeO6ZoXTg_1786730609
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A8B8E18002F8;
	Fri, 14 Aug 2026 18:03:28 +0000 (UTC)
Received: from fedora (unknown [10.44.32.2])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A2453180034C;
	Fri, 14 Aug 2026 18:03:19 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 14 Aug 2026 20:03:28 +0200 (CEST)
Date: Fri, 14 Aug 2026 20:03:15 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
Cc: joel.granados@kernel.org, kees@kernel.org, brauner@kernel.org,
	mingo@redhat.com, peterz@infradead.org, akpm@linux-foundation.org,
	jack@suse.cz, avagin@gmail.com, ptikhomirov@virtuozzo.com,
	mjguzik@gmail.com, include@grrlz.net, ebiederm@xmission.com,
	legion@kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com, kys@microsoft.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] reboot: fix cad_pid use-after-free race
Message-ID: <an9YY8DzjiDLa2tr@redhat.com>
References: <20260814040944.16561-1-blbllhy@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814040944.16561-1-blbllhy@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 08/14, Cen Zhang (Microsoft) wrote:
>
> v4:
>  - Rebase on sysctl-next after Oleg's cad_pid sysctl placement change.
>  - Fold the two-patch v3 series into a single lifetime fix.
>  - Move kill_cad_pid() implementation to kernel/signal.c.
>  - Export kill_cad_pid() and stop exporting the raw cad_pid pointer.
>  - Update proc_do_cad_pid() in kernel/reboot.c.
>  - Add explicit includes for the RCU API and kill_cad_pid().
>  - Preserve the original unprivileged impact context while noting that
>    the namespace permission path has been fixed separately.

I don't see other changes in this version, so

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

