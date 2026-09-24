Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68060376BC1
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 14:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790259571; cv=none; b=j2Itw3tlUQak5/ufowBq5S31oOXagfLQ2rvK95Z3pBiFAWp5zi/GbJAXSq+ibDAtt8lVfUs4fIycOfbJ/za/lBoJYUItIWFWB2NtdSl8IKsIF1cFfX7/HV5TOifYSeYvCep8YtpYIsSthvK/qpQIQv6ySsC2C9MLx/WUJlR03BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790259571; c=relaxed/simple;
	bh=TWdASb3MyAf7mGzhM1GabLO0eutszFmZKdYoyrSrb/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gHVd0Sd6eOlSWpzDk/jtPi2kie1RgdtrBVLitZM23qlJUuw8vNmYaheCsEaRTOq4nAGhEx1t4uPzCpAlg7vJfzNJZewLFefpJeavlpfZ8ViNw6zGBSzFUbG5KSliN40+I46fp70eoeIQwTV/baZBJupkVV8Nrk90vZGtmC21cdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=xUsYOoK3; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="xUsYOoK3"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-328664e051fso2373633eec.1
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 07:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1790259565; x=1790864365; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l5t+RkrxBW/tPG0f8s8vACvjj/UzJW53i35clI9VtqY=;
        b=xUsYOoK3GAHlCcY3Apa/Z4b/UYuwhAOdAh4pYHuimBtUMwFObIHfZeSd8GtmaKBqyh
         VNScnMR2fSPIqEpCCsYjigBiLXBr3g1EaT0YYmCUJ4KugsX006BE9dQJ47nv65UnYuGd
         9sjuAXkibl6VRbaC70Z9QvL9h5eTrdkmTQvuNMfN5fYSNJgMJHRE93sGNB2ht3MowNpV
         Suq0BxBNGDyVxFPwsC7EovxYj9CmxjJds6rXnn123huZXZcJItEZV6HJZgxfykBJaFFQ
         kSUADyZ8D5ee3nUtzdtxg/8ktkfurjEmH0H0PaUUuonLrNto10o8WGMyGdjPXsR2ITdv
         cHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790259565; x=1790864365;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l5t+RkrxBW/tPG0f8s8vACvjj/UzJW53i35clI9VtqY=;
        b=LmVZN1fgoltTApedKRCgt3HW7KGJqjNi3KGpgrmH9UDRUn8FzBudFT/Qcpv0bNk1HW
         Ybr14CGiv3Jf3mZBd5weIunx/XdGy/vPPqQHbL+ybjxhKb5xPggBq5lB+UFIYp5LwLBB
         RiKtjo6r4ddP3Lv+phQYQw+i6DPdzEUOEDqhx+/S8TJFaa5maHgDZ+yjjr/jROxhvMWk
         74nOubi4UEaALNqTFLDeOSSZIfXyDPsLoXPycwSK50m7kX26PscvAy8/VULnQqhtUHlg
         xibYQOSs+IUhIIyjp7AVF2vQ1IJQOJNiXIrwLuD+iflK7aU1QjXd9rLTKZlU5xO2Ma4o
         75jg==
X-Forwarded-Encrypted: i=1; AKwUvBxtq9A9EBIy1vWKf/e/lSNC2zjamAFSgaH/QDKr+DxGYucHGHoWDANauAuB2J6y9q4Zssynoh4=@vger.kernel.org
X-Gm-Message-State: AFuF++lZU+tOa6Jf04IxKXtLu3RilNJkmMZPGFHJJ8hMavNokskhsKDg
	A4J9r/ONaaTnmN/qLvAk/8z1bXCE+PJNRgEJqD1Bv0YboO//svJI7VPUT6cC2Xko+PY=
X-Gm-Gg: AYBFou3dr9OObwjq8Lrdx0kGoErdd2lw+ZJj8xBgCrDSu7P++XEk0GBYp3aoMshBCNz
	FvUiQSGjJj3cAxVQbvMlezqns2Rhc+zCl3jMgagyicoJWsyoaVUYEjTA5xG485h4Gmxz+mXC/8c
	JjB8JBh/DI13xWYt2zO1i/JusVUX++9ieR7qaSdqI4yDSG9w8J6cVGyc9OQylO6Ko3Xf2tr7q8v
	mb2nSMOl44pDuJneZ4E5utUvf1JAMS0HbUSYRX/kvUshZPMDd4iQWdUnHxBXisnyzYpAYkuqe1q
	iT9IES7JLDUavPjK4K1xpqbjHl+h6dCRQjfUmZ1CLU78b1kDGwd1A+pDQpJqBJk6UCEb2A7X0cH
	Earm1/viN3kU0aSekCT9GYx4f51cNEk/eN1n0k2dhnWAqTtiRYQ0PFll++BDTRX3xE5tx/JD5K6
	T3SA20/qmWAj67FfNB4/9yEPQZFbMyZi4fcRv+cydwmL30ywvUarpFWR8CKzvaOzyG0Xr+m6j1C
	Jb+RZBFaUuFtKupuzSYAGOGLoakCcS+ns+kHT/qrFSWnmIhYHL91Vkpaw==
X-Received: by 2002:a05:693c:87c7:20b0:33b:f566:eca9 with SMTP id 5a478bee46e88-34001c1401fmr2175061eec.11.1790259563746;
        Thu, 24 Sep 2026 07:19:23 -0700 (PDT)
Received: from [192.168.1.125] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e9684ed70sm12529265eec.19.2026.09.24.07.19.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 07:19:23 -0700 (PDT)
Message-ID: <e1fb70aa-cc4c-4ed5-809a-e8babd52dacf@kernel.dk>
Date: Thu, 24 Sep 2026 08:19:22 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/17] exec: cancel io_uring requests before
 de_thread()
To: Christian Brauner <brauner@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Chris Mason <mason@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 NeilBrown <neil@brown.name>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
 io-uring@vger.kernel.org, stable@vger.kernel.org
References: <20260921-work-coredump-fixes-v3-0-8e4adb1619e6@kernel.org>
 <20260921-work-coredump-fixes-v3-12-8e4adb1619e6@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260921-work-coredump-fixes-v3-12-8e4adb1619e6@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/21/26 7:45 AM, Christian Brauner wrote:
> begin_new_exec() cancels the exec'ing thread's io_uring requests after
> de_thread() made it the only thread in the thread-group. Now
> io_uring_task_cancel() runs task work after. If it runs a
> create_worker_cb() item then a io-wq queued on the thread before the
> exec creates a new io-wq worker thread.
> 
> Said thread joins the thread-group which de_thread() just took down. The
> io-iwq sticks around until it notices that its workqueue is dying. But
> code after de_thread() relies on being single-threaded.
> 
> Move io_uring_task_cancel() before de_thread() but behind the point of
> no return. Any worker created during task work run from
> io_uring_task_cancel() is just a sibling thread that de_thread() will
> take down and reap.
> 
> Once io_uring_task_cancel() returned the thread has neither a task
> context nor a workqueue left so nothing can add a thread behind
> de_thread()'s back anymore.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

