Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67A0558200
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 14:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788877294; cv=none; b=EEUTj1I57Dm8k/AwXP1Nrkbaoc2D5KptmVJdACi1aHjzoKcgOxdOfHPeLExQyHrEikGwNTcRjPzmg3jxYit7ilsHOx253m+eIA1MYCjGfL23JgN1K+f+uOar+EoSnx3in3SJSCPf09wRv23zDbDyvJk0Am1rqhbZAX7btBBzJiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788877294; c=relaxed/simple;
	bh=t9VEB+Wx7FTfVlIWnys+TVYHiif/HGxsyKc57vmrBlg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVw7/FiTIepuYkI3Dy3h8RhPho8og/Xq/0NyUGah/O6SJ5YxtontEJmK1UdtdAa0hF0FLck06fSfKL6pYteJ1R6KC+HV5jqY5ZDNyiym/MYjKI99eIk8RyfS9zjTI5FDlYb1jO61u6Npqtg0YV8+4FdeHDWzpGJBajExcb7hFnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MSv2Dx+/; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSv2Dx+/"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d91ded8174so36835535ad.1
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 07:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788877287; x=1789482087; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=elHR2dmgdiO2iJMqseykTVVlGqNYHDXkrEZm70hbhR4=;
        b=MSv2Dx+/UvwTHGw1G0odP9lswe4ypJmsfz8xFoG88tzngkBhH7g+ch3R5cLOMPmMut
         7oWZkXB6LIYNyHEb2zwqv8L5jwx3R9CBMSYKwq+k+UUi/6ytJVRAEB8w07WVjzKCn4dI
         M7mQ7HnC6eo0CRtA7ADyjcqpEXncCwdEG5jOAZmSqlsMqDF3szr0Stl4gkUE1I7t02WJ
         1mVewZr6a5QHg85jUZC28pFyk68shDryPL+ok70rxI4Hn0dqAPq/FSRONUDLpAJHSP4r
         FL/exm2vrYonpJNlDPcFI/St3UIdnlZKsEQTYW3qgHmTtbF270NRjACgwfaBhpd1olKn
         CJ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788877287; x=1789482087;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=elHR2dmgdiO2iJMqseykTVVlGqNYHDXkrEZm70hbhR4=;
        b=HqWaQ1dUvz3fVaiq6wQLBdKX95vEuze0HWpvn0+TixEzMZ6DHIxL+j/cm/tH3Vr1Sn
         QIAmiY86PRsraIzayiD/wYbqP8O5ji3DtYg43H6i0HJ1/RPS0/7WMQ/pjUs8PbgSezyO
         6CcLLlUUWmkRVLiuNRnDstNbTe2uyCAn8Eb1MyFSW9cYxx3PPlg8h1naxGJOWoIWhW7N
         v/9z7Rx7KO8wn4UCBT/xH7UzmmTBcCchs+WkTZxz7Nm1jNkXTxp3RAh0x0PAUnVkMvR5
         lFWCRQzetc6vwaRtBHf/xqu8boISN5z3pndIoPmoquMl/d8Mhzytshq7qVMg3p0TyIKO
         CZUw==
X-Forwarded-Encrypted: i=1; AKwUvByxMO/sFqB7xYO3U7gOykdi/s+1wuQIrhJSI1ELilG8Mojf+cpqcko6q8lLKpY8Nsx/3SClz9E=@vger.kernel.org
X-Gm-Message-State: AFuF++mlVUHoaCMPXv0lQXl62rGp106ishx5aoY36YeeDY0Ri6M9+E6K
	nb1a0oCCCnb5ps705+8TzqyLW8a/wfbKsjtlSBxbh6YSK+qZSpodGMih
X-Gm-Gg: AYBFou33r7HirYfJARqLENYO6hJ3AQ7s3tJqtIXRQtJWvDXC6mIEArXit9XX7ZQwA9q
	Xffrl8itp9Xrd3qkZUlAXrwvXo3XW5zlOe6Y9Wz0h8aVLHPs5tGER4beyEaR56Ambsr4lgA+ExE
	Avu/0JsW7NWqTWa9riZtM36nN/h3h3ZnujPtyl4q3HM5pHaDmbLR7Nik8Hek2iIW6Z4zG06QuTP
	UREA3Kvh1BQSoohWrzNiSi2ffkf9yCgGYIa7/HB3wZ1gk8sgTKg+i4Hsltj0L+vBGoViDPTDG9y
	g1UgwcXKa4dvwhZg6kPIsq5HrKAuibs57laMx3H1RctVXP+twGIQNnSLDV6gtkG7AvTLoHjt5vf
	QI1PjExeBHcnoNHFsdqcZubtX55rwY/ABAY3x6WiS9LpYY37wHFQQ8j5RuMkXxQj9wTqyH8YVyM
	HNg2Zrmlsim9JoVUm2cW+s9o8Y9kFneQ1v8arYoeDToA==
X-Received: by 2002:a17:903:11c8:b0:2d8:d4de:fa80 with SMTP id d9443c01a7336-2db1235721dmr410393595ad.4.1788877286477;
        Tue, 08 Sep 2026 07:21:26 -0700 (PDT)
Received: from pc636 ([125.29.25.186])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db14841054sm61015055ad.3.2026.09.08.07.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 07:21:25 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 8 Sep 2026 16:21:20 +0200
To: Hillf Danton <hdanton@sina.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
	Baoquan He <bhe@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
	stable@vger.kernel.org, Dev Jain <dev.jain@arm.com>,
	Ye Liu <ye.liu@linux.dev>, lirongqing <lirongqing@baidu.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH RESEND] mm/vmalloc: Use dedicated unbound workqueues for
 vmap drain
Message-ID: <aqAZ4H8mauWw4JVM@pc636>
References: <20260905152717.11711-1-urezki@gmail.com>
 <20260906035027.2106-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260906035027.2106-1-hdanton@sina.com>

On Sun, Sep 06, 2026 at 11:50:24AM +0800, Hillf Danton wrote:
> On Sat, 5 Sep 2026 17:27:17 +0200 "Uladzislau Rezki (Sony)" wrote:
> > drain_vmap_area_work() function can take >10ms to complete
> > when there are many accumulated vmap areas in a system with
> > high CPU count, causing workqueue watchdog warnings when run
> > via schedule_work():
> > 
> >   workqueue: drain_vmap_area_work hogged CPU for >10000us
> > 
> > Move the top-level drain work to a dedicated WQ_UNBOUND
> > workqueue so the scheduler can run this background work
> > on any available CPU, improving responsiveness. Use the
> > WQ_MEM_RECLAIM to ensure forward progress under memory
> > pressure.
> >
> If the dedicated worker will run for 4ms on CPU2 before the tick irq kicks it
> off cpu, the system event worker on CPU2 has to wait at least for 4ms to handle
> 200 events for example in 1ms, the net effect is the same as the current scenario
> where 200 events wait for the drain_vmap_area_work to complete on CPU1.
>
It is scheduling decision. We do not want to tune any prio here.

> 
> Different workers does not help to dramatically decrement the micro seconds
> the drain_vmap_area_work takes.
The problem of current approach consists from at least two problems:

- doing progress under memory pressure;
- do not schedule all workers on current CPU and let schedule to find
  the most attractive CPU from its point of view. For example: less busy
  RQ, less energy consuming CPU and so on

--
Uladzislau Rezki
