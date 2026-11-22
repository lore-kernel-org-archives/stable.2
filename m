Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795372992;
	b=J7r+o46u5TgUl3WZCki+7nfkJ0TiGrgfHgPwlh2Z36J2PPrGb/p3WtD4yH47ZorubnkA
	 Aau9uRxJtcHw7tdb2iglKOhzlWtwQJXhc4+YQvPi4Uag5ZRQBV3yOlutM4PLtMbgfjgx9
	 iLLH7Wf7iQZXcNbQ41Hn1DkyKCWqMj+GPgvwYU7ZVZWBhwLoQcpNP1YM5m4DqRd+kdLXS
	 XTw/sIMe23vfybvApu441ZsaIrkIg9gI9Bxcmn9PlVI1ktSefFujAPMxVqyh8H4pfPUHR
	 gAPUk+LtWoYENCPHQby2MVUd6xUwANzQX45uBliaoYj3T8P9qUG5v7sFFL9ck8F94lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795372992;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cBcRUPE1iZgUTO5vL9PNhYI1VQ/6dT8/jQCn5srupcA=;
	b=FpRUgwxVP7MYQBvQqONDCWgQq83j8zYAlhF9zGaLVDD4hMwTIzPFIKCoSwySkmUFTWJu
	 IxWZL/FZShDMjFdCXaBJEtzm4Skx8vFErLRBrfqstrLlN+53Ldz8McGl9mdAT34wncO9d
	 kOBxkYgBlLLnza/zC4zhbCorMpCN28ML5rsIjD3ZuD0Q0F8R0IMyAMF29CV5iYBjY5aSl
	 Zbg2HOruI543o0Sk6/cp6hdulj7yOl5d43gEdWw/sMUIV+BARS7b/GZ7imp7XeOHRMHwA
	 XpDjAjSME6Qk/WyXxjZkkQSPmXmX6CRfJujVfhKJvfIW4V/zhdMdfieEb3BMu8xD9Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="GUvz1/hg";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=kA5FPwu7;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375CC606A320
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 18:43:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 375CC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GUvz1/hg;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=kA5FPwu7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795372990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cBcRUPE1iZgUTO5vL9PNhYI1VQ/6dT8/jQCn5srupcA=;
	b=GUvz1/hgDWYKSfG7DpRvmwkOrncNOKpEKTrcr6r5w0UWrA51mC9rsOvqfGBhsskFBO/RQ7
	OA+KTVsHgJ2+hJQXc7YuglHGzORrRCI7zFQS6Z8NLo6oVHSvDxjKaUKMeFB2RPXSJH0tRv
	dOXid9y10TdKtOzSReJ2TRrvJfiNmjQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-DbBCeFgSOZ-dI-eJNZapfg-1; Sun, 22 Nov 2026 18:43:08 +0000
X-MC-Unique: DbBCeFgSOZ-dI-eJNZapfg-1
X-Mimecast-MFC-AGG-ID: DbBCeFgSOZ-dI-eJNZapfg_1795372988
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-55d32f54d21so54960911cf.2
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 10:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795372988; x=1795977788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cBcRUPE1iZgUTO5vL9PNhYI1VQ/6dT8/jQCn5srupcA=;
        b=kA5FPwu7R6lZ/mBGiPplBrZNrp83YZBkHLHEEtso6d7pPoUds5cD/6OjIJbgIfoZv2
         SjoT18htPH8yAW+aOUs8G+mK9LeYdRFQ/Rzqv71davcXAYdhvr9uYNn92czEqfHGpuOg
         FQcX1bp1YG+rM/X/0/+xYq0FX3cs1ZBO2EvuEDbJLUuKkYGmgGJXUtSWIOq2MV4D39VG
         5Lf/bhYCL2ojZjPWcdjTqEiUANxzQzWcbuvTUcZWz7eXUHnMvRk9Ra+4f3IjFXcoOmX9
         0pqV1SY9fQKI1wCfX34e3xB6a7noQPlz2OGGH+4c1jpKXjEoZTtS8lU4Gzj2CJDZQ7JX
         ipLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795372988; x=1795977788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cBcRUPE1iZgUTO5vL9PNhYI1VQ/6dT8/jQCn5srupcA=;
        b=2L0rufdLwRW3rPE7Li9JikkGKDO5hK6yvXL1xqwCxM2jo6DAQoGogOoLXdRgoxprY5
         9A2SMp0wY+9pfoJ4/vCsNgEJX7/rrVETPh9mhpAkCGXmQbw+EtSI0NHgom49E27sqMik
         YzakxmYyx+80tlxNcV4BktqznVQ7T5OCunO7zMGdUIW8R6V/C+zx1aPCmQ+U1msAa5RC
         nPggu1DmtVk933ZbkkNyWgAGK/ipDxms0a2H5IszFDPAnGUfHx/DfgTmhGw7jyQUpLVC
         DmyUj0wfe2+vnjySkzcfGJk3n015lW4+Uwlspi1jGSn4m0sYrXLSKRhHvo4u8ZmkZtJ5
         xiAQ==
X-Forwarded-Encrypted: i=1; AL+hErEty2ldy9Mfw89ebUzA40C9oIVa+DtE8oRQ749gVOLEiEcrrnbf1WzCLrhAKNHetPEUz/dOEeI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/njmdwvJ/hZ3CTm/wjxDcLIZennUeEq/xT5h/84l1QGuDIWi2G
	WVhovB4RlgvJXpWZY5Zd1obUTr+0IJw08GhOkY2HEkP9i0HNKdwvxwno2qV9xq/HuSylTjc697B
	2aBGg/9p0nwgGow7D8yzRnK6RZkUPort0fId+6/jGpoIYeskR/IFlbC+zRw==
X-Gm-Gg: AZFdTZcaQt4/HxMQ07IK+wo0j+ywovH871V+y/gebgI/Cuvmn0cJkdnNOat1UjGEP3C
	Kis8w0+STEeER5Mw3ZeN/QLte1AIUtZf2wlMieQjj4cibZeVWb5WG58uJoLciNRQftb+nN1FCsk
	37zsZ5UFGrxFjGQ2RlFNnaNJFFyhv7vldkBoluY+D4D51ryOW1NTDMqKy6HDg977nTnQMXNodTs
	1z1P5fdeeKXmuZZFGWAyYbuVxO3QG0Hxc/+iTmmZ4hdQVFxSKE5DzFkxHEHlH9PGrGMkuK8DO2h
	WzYRHgVQ1XQDTYAaXvXGYtXMHIFSDD+I158SKohlSmnlK2AJsrSxt3CtEecPOHM/NWI/FkL0nHW
	1cjA5ahlHHLu1oOG7b+sfNM4B31kwQ1a/Tozsdu+ecwD8H5rm9FYh9KfwFDcIP3RlZKiACKG44Y
	M3Ijzs+toyOixhQjzwV0wq5w2hDGNRBCqsrbI1Fe4b/y3x8lZ6wWxU4BBmpzIMDbrO5MDS+ijGU
	F8WBkBq4qVMUlcDjXqF4NlJlcAU7vYcgokcdc/RRKfOpYjOGiNV
X-Received: by 2002:a05:622a:580b:b0:537:a19c:aaad with SMTP id d75a77b69052e-55d76adb4f5mr145678201cf.65.1795372987753;
        Sun, 22 Nov 2026 10:43:07 -0800 (PST)
X-Received: by 2002:a05:622a:580b:b0:537:a19c:aaad with SMTP id d75a77b69052e-55d76adb4f5mr145678041cf.65.1795372987327;
        Sun, 22 Nov 2026 10:43:07 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d7882c64fsm79845241cf.10.2026.11.22.10.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 10:43:07 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: Xiubo Li <xiubo.li@clyso.com>
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	ceph-devel@vger.kernel.org,
	stable@vger.kernel.org,
	security@kernel.org,
	Quinn Grant <leograntquinn@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ceph: ignore a cap IMPORT peer that names the importing MDS
Date: Sun, 22 Nov 2026 18:43:04 +0000
Message-Id: <20261122184304.1303832-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261121-b4-ceph-cap-import-self-peer-v1-1-9cbc14a6c8b7@clyso.com>
References: <20261121-b4-ceph-cap-import-self-peer-v1-1-9cbc14a6c8b7@clyso.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Xiubo,

Thanks for the fix.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

Alex

