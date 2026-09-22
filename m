Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5553C6600
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790090874; cv=none; b=nhPO3xf8GqjmguNuLRh/SFlDK2Qxf2WOJcc0KvsiI4V5Tv8IjSp5X+hytZKqx/qYxxVXOrFdaDpmaQCUuGbOKDHGe63IyLJhHPL+pUVjvB/AqDlSXfwSE4SxEUsXcsHWc3ug7WOozeiN21h1iYVTq5+OGWfj/MjHgrfeIhweNdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790090874; c=relaxed/simple;
	bh=H6M2+2ePKHnNXtCxv8bZ8wAVt5XsjCTjUh+IXXp4Ros=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Thk3as8RdwmniOY+q1jjXuqzPitOw4o51gxRdf6ypFDJDXk6WWoC1xdV6vBGY0mIPDZFcbZtT94ZWm6X79vCA2de0FM5Zed5hcXi5Sno7bf2aBztW9Xv5e6Rp/BahV4HfAFgNfjZ+9Yv9t7/zBzjgwib9kLU8yIzB+U+JqdeJKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZPEyLpS1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cbJN0B15; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZPEyLpS1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cbJN0B15"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790090870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SEowbgJIDHpYJATL6KIUYHLNQoCqqGPHET4KCWOduog=;
	b=ZPEyLpS1GwRcj/S3FgakTWcRhR/sX4Djt8rDj449Uo+M+3F4IR/f/tfjNp/Juqg1SbO34G
	KC6tS0UfwVMdy7STKtMKCHqw/NzsH8SqJpNgJWBmzgMfrtK2KDzA/48TeZy+ClqvNoNMe1
	MIYR0oSNwHtD+VMSIlgF5o0BI2S6xFM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-gBxOGlUcMPWiuPxKQiv7ng-1; Tue, 22 Sep 2026 11:27:48 -0400
X-MC-Unique: gBxOGlUcMPWiuPxKQiv7ng-1
X-Mimecast-MFC-AGG-ID: gBxOGlUcMPWiuPxKQiv7ng_1790090867
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49e823c4868so35050385e9.0
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 08:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790090867; x=1790695667; darn=vger.kernel.org;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SEowbgJIDHpYJATL6KIUYHLNQoCqqGPHET4KCWOduog=;
        b=cbJN0B151Ta+VBlvHJEdHry0GaMsQGfYgyiPxEsuqVqLVrWVxOpewoausweIOWbH/3
         Ha4fr8Rtu/iSmvJ+XPobzo2KQrZ5fKqqQiLXgolbT0uUnnb39TMKUZJDuhr7wo4z+xPl
         HFjpX5123qWRXpCx8ky/ZrdBqM4++vy7l4ejzSlZzF+u5iOlo3xjgTGIkF7kdoAeLsrP
         DA5AwMKcHoD8pN+XB8lGEY+mZeSajYvYr18yucGeDOBMNaWDZW82qohRyfPeFHsvkohb
         mPw8wQgKTUq0uhmbXdXuBUifnzp5IXGsHmTzeZth+HHDRAIDiDBu/TKm5NnF7gVS7qAu
         s99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790090867; x=1790695667;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=SEowbgJIDHpYJATL6KIUYHLNQoCqqGPHET4KCWOduog=;
        b=I7pZebxSr6WJIZ217lfWANYlYGn7VEy64ScW7vAB1kwZHDyq8Z2+dTFMLcDiQGOyEO
         kUncw4aMdgBsTktFnlkN78H+gJEkIlNoz9OkrzZgoJa6WJmDZgyEnZG0RE61JclFxj4/
         NSdUPCgmJE/73i5X0lvhoEuPKRPPrzLeLVKqXmhbtB4xlwy3x/VrsaCZTU9a1SGk9Xn6
         C7thcsrjsfjK7xqkQSGHzYbPqhjuy9EcJxPZ1TI40gWb/07iM/IL+VHcbuJcF+zhxJBE
         bHvDFNYUyKRoq39AJj2PQUThlm1ybZSGv60U/qVZyDz5PThdohTQhsDqXrUyNs+WKNQi
         5s9w==
X-Forwarded-Encrypted: i=1; AKwUvBxvyh7mlTMbSy6wGYIHhN0vg2obQnarssmLu6N/nAWP0rtc+vPu7QtNjJ83ADejIN3I6Wnhnmw=@vger.kernel.org
X-Gm-Message-State: AFuF++mZiL4JSd6q/ozZBQDNtWRheKLeHzKk4rz7NsVZQtzYVhG6c6Hf
	rg8eeFiz9ISa6x4o/ZNplUbZcZuZ7rfqUNIaPcBPpZa9oY8xvpqiDL7rorT9XvjQti825711sGS
	4IrSMJH0GrpaVo2oTacZMOKh0ShWR8MY6nSm90PrzehYbnXHZyGYiUdjcgLhY1Rih0DLlWQHDqG
	HWOMV83cMNRaphLZLlUWvKew8QQa6RZmLJwOn6WyfE2dw=
X-Gm-Gg: AYBFou1loKoZuvIBmctffN6OflBeewTqNRxqE6h3R/MfC3u3mMvEAGYwF3ok7I3QOdr
	j1KdMpUmZa/df6HkSQ1IhaD/aNwQ0lTPTB7RISQHf3InzrV96vrJxdcuXcn+IFQN+02G/82sbHD
	tGeX4DpzUvYLXMUws0qBsfu576nZ0A/xq4KSwGnEnB+0mZSKpkamLfSHDyZqrshn1wQBxx95kDs
	tAKwOn6QZ8ao60YPx36597rCGJ4/AVWUW3wt6cAC/h9oz6hxlaQtIQWQJBk4NGrur52A21ie3Id
	c6niIFO3UapENT8KpAUxRL/el/zPXRsI1dCtvLrBoUUnb/6OZRN/6oNOmpUzwFI1hTf09YW//xF
	CjukasQBo1Wngt0XaKBDpCF85CFlA
X-Received: by 2002:a05:600c:34c7:b0:49c:ff8d:b548 with SMTP id 5b1f17b1804b1-49fc5726cfcmr277167075e9.11.1790090867482;
        Tue, 22 Sep 2026 08:27:47 -0700 (PDT)
X-Received: by 2002:a05:600c:34c7:b0:49c:ff8d:b548 with SMTP id 5b1f17b1804b1-49fc5726cfcmr277166705e9.11.1790090867129;
        Tue, 22 Sep 2026 08:27:47 -0700 (PDT)
Received: from aconole-thinkpadt14gen4.rmtusnh.csb ([216.212.25.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdab0e46fsm13166415e9.3.2026.09.22.08.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 08:27:46 -0700 (PDT)
From: Aaron Conole <aconole@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org,  Pablo Neira Ayuso <pablo@netfilter.org>,
  Florian Westphal <fw@strlen.de>,  Phil Sutter <phil@nwl.cc>,  "David S.
 Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Simon
 Horman <horms@kernel.org>,  Eelco Chaudron <echaudro@redhat.com>,  Jamal
 Hadi Salim <jhs@mojatatu.com>,  Jiri Pirko <jiri@resnulli.us>,  Xin Long
 <lucien.xin@gmail.com>,  Marcelo Ricardo Leitner
 <marcelo.leitner@gmail.com>,  netfilter-devel@vger.kernel.org,
  coreteam@netfilter.org,  linux-kernel@vger.kernel.org,
  dev@openvswitch.org,  stable@vger.kernel.org
Subject: Re: [PATCH net 5/6] net/sched: act_ct: remove 'add_helper' dead code
In-Reply-To: <20260921145655.3167436-6-i.maximets@ovn.org> (Ilya Maximets's
	message of "Mon, 21 Sep 2026 16:55:47 +0200")
References: <20260921145655.3167436-1-i.maximets@ovn.org>
	<20260921145655.3167436-6-i.maximets@ovn.org>
Date: Tue, 22 Sep 2026 11:27:43 -0400
Message-ID: <f7t8q4tb91s.fsf@aconole-thinkpadt14gen4.rmtusnh.csb>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ilya Maximets <i.maximets@ovn.org> writes:

> This variable can only become 'true' when the connection is not
> confirmed, but it is only checked when it is confirmed.  So, it can be
> treated as being always false and just removed.
>
> Fixes: a21b06e73191 ("net: sched: add helper support in act_ct")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---

Reviewed-by: Aaron Conole <aconole@redhat.com>

