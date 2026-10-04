Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com [74.125.228.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805AE3F20ED
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 12:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791117100; cv=pass; b=BA0jq1WPmqcJtfM6DgcLRAup7UNsdkuiciEoyU9cXinwI3G6gZqpQ6pJhpoXI0qbfAKB46pby0bGZ4oKQNyn2EP/xfea0tSuDR/twFnJiaje5dkoJtgZnENZflEaE4TYY2Va2rDDuMRMNyN5uAxkU4f+spXZ8J3qcXYgiNhfxvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791117100; c=relaxed/simple;
	bh=GXfjk93rqVjkEm8QtrTGYzEWMYxFujv0Lq5SqSgVimE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cOssdOm007Kc4viEnC2zcia7P+2GbToB0K7+o7uNHw4oQSmsiVkTBThe8HqkgGYCGaEvKfETpfBQ4PHNaUueNupnmpE3isAcp7FtaqUTmkgaMT0UV1havTI9cVZAdVb3grBUSS81UYWH9T6Wefzb9pWstuQs056YylUz1ZE2FwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oItSJmc5; arc=pass smtp.client-ip=74.125.228.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oItSJmc5"
Received: by mail-pz2-f37.google.com with SMTP id 41be03b00d2f7-cc7c9c2df74so190950a12.0
        for <stable@vger.kernel.org>; Sun, 04 Oct 2026 05:31:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791117099; cv=none;
        d=google.com; s=arc-20260327;
        b=hQrtW7x06MMdDw8ARXs2Xo+yK3KCYcSwOrXnWmDwXq2VgbAtSgyAcp2apSdy+FMqag
         gAM4ZOZCtPXzDG58Zt9ak6XoKb8PRf1h+tQmq8ejwkQb/5OfAtxQ9OxcLaNRUOwmMkoq
         W+i1FaIbIZWPsRy35NAaaupSyy2uW14U4z1JEjNyHClXnDYiU2a0118ACbSEF2PvOCZH
         B2VSZptC35czv+OB6+HE7epLQnRKxhrgPDLQvi+YPd2u7Fa/yWNR3nOOkA52+kaJL2wg
         cCQFlQVJ4AV5QccWrQga3lkCwcsA/YjkDodUaLH+wXl7jm+qg36tyg+x1od+wsC3eQnw
         hnKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GXfjk93rqVjkEm8QtrTGYzEWMYxFujv0Lq5SqSgVimE=;
        fh=IgYrQMUEgSoQ2yfXBAOEhv+Ctkn3fmWySmvzE4h/udg=;
        b=bfucQk3WaD+EDT5adSxD092WNEHnhXRfaQA0txGVJodzuulv9ShuLOJnBBmtEZtAdy
         W7qQ82FQsHVCoB91ykea2aA+gkOhInqaQwkKeG0XHn7scfoVcTrmWl5KHnCXjvCkD5sS
         Wom7MkjgC/TzDzYQPvnbvjjsnAcpqymRmsJC6M90XFGBXaVRaC0JzgtbTLDEID1EnQqv
         o858n4JAKzHJRs8GE1wHzAzRWCcuk2CukZ1K8L6iIS3S3ISy8YR0zmIguKhrxhPpiIEj
         TKx9927d6xz7NZFUJCb2GpkSMc0EiOg9WVeXdmOfYPuBadNIy2qHs1/lzskB7tHSKykb
         Ez5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791117099; x=1791721899; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GXfjk93rqVjkEm8QtrTGYzEWMYxFujv0Lq5SqSgVimE=;
        b=oItSJmc5gplGn+GwGiz/D479gTHCHpP74bE0H2I+RO8okuiDd85BMkhj7l7edgbp19
         hIwPIhWIXeb08HAt6AqvoSq1VbFPcYa2os5RElxw4TBIleXKGKJ5PD7MQzEBZpUIOoov
         zO+OGA1EYRuLkGaNwgxDIKChUpYgwHgYLwszFPfmsfG5Z/S3HuyeKNI/ozl/o3ofUHSf
         vgAU/ps4ydoV+8w1FYlr6Fi6y3mNaQ+Z7a52yrH+vGtqGWRHOWPjNFyGTGfGOK0YJMsp
         ofD6bcZP96QzcziVT2nIsLY29w67wXHxPIYZO5JQIL6lqMeryxilSBdKuw++Y49uSgB/
         I8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791117099; x=1791721899;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GXfjk93rqVjkEm8QtrTGYzEWMYxFujv0Lq5SqSgVimE=;
        b=MK4ST6BJS3zjtR25exHVO5UGrL9kpaEg396aXt4aJUVQQw3uFsRidqSA9dVwqHZU4I
         DS5oIZhXPY2j9+LeMr/o+5OPLzrOPWcTkoPPa4ZpEx58wG8tY+1byhPlRMSHjBosj6Sf
         rWzp2+hcoFZqljAxPiDPTXv2qMlm+4AsT+GHWUv3J9Q5OwgfNk6gNiDeo5LIAqpBOfxc
         /nmW4KP+XJJ6piCUVGVfCZYw9qLR9Z+daoHPWFtyKkAn6G2F+AVDWzPX6nkcsRA2gS9m
         CnRLTD3OuLLjwzRKVL7EZV07vHSMiIkj7N2/VPVqzlvoB2O9xcLCnUaEpF43P9k8RZY/
         TtBA==
X-Forwarded-Encrypted: i=1; AKwUvBwqdWm2bn4BGh+5EvCiTzWw007ASWlYYn2hkqt7Zk/rcty8Wf4BTQdJDnXh87CvMFf/PgPxsis=@vger.kernel.org
X-Gm-Message-State: AFq9FYIjWgEgSsc2cSTdE1dgc/+MRVTXE5rMwWsaJM+zYYx+T6umiUwG
	1Tl7mUPOCpCO/hqrCENY2c+j5dfTw1kgMb8zxqdsUy6sNGoK2QGQ9QoX4roaDUaeFs4QUBLjCgR
	bleLIXDgxTrWzN+TcOJ9t1DI8P82qLCQt61Yp
X-Gm-Gg: AYBFou3pyxUsqkbKV4CF2m5dtVIc/kHcwKmCO8XhDsLN9v+foYkJaFQ6EzcrMpKIplq
	sSJEi9QSjzIfrfOvXLXmaKeNz8NCXuJrh7lvR7IfJTlIr0n5rv5qN980g1f1libS0rwwpwwa+G1
	typ24UIm4H41iIozd3ChLX6FoXh154vqEwfBqcHeZAUWW7K4v8vWj2MFjkAQdX+75ViYfoVjVI8
	1gKAZQIfl0ymM8FzxcnMkldVQLlnBAIxlw7MMfKw4g7649E3XfimnldyA555MUL3LRVmV+e5+6A
	xCspoNDXo6B4t2/NdMzaD5sWEpK+VntydKvw+7AFqyoKjibdVe14weYP
X-Received: by 2002:a17:90b:268f:b0:3a4:e735:b3a3 with SMTP id
 98e67ed59e1d1-3a6cec8cd26mr4508237a91.40.1791117098607; Sun, 04 Oct 2026
 05:31:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001213915.1326602-1-adrianox@gmail.com> <20261003171352.10244-1-neganhat@gmail.com>
In-Reply-To: <20261003171352.10244-1-neganhat@gmail.com>
From: =?UTF-8?Q?Adriano_C=C3=B3rdova?= <adrianox@gmail.com>
Date: Sun, 4 Oct 2026 09:31:26 -0300
X-Gm-Features: AclHuK8R9Jo3-68_DE9TmeC3aACV1AZP1ZEQoMrqadGoXULvBmqZTbxMVHejPuU
Message-ID: <CAMGU2hUmzd1i0mpLG0M2sj1Ki+2Esz5vFQjqJ6F6RnJM3RafyA@mail.gmail.com>
Subject: Re: ecryptfs: validate auth tok payload size
To: Nguyen Duy Nhat Anh <neganhat@gmail.com>
Cc: code@tyhicks.com, ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, syzbot+03c68e42ce4b33f7ce9b@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El s=C3=A1b, 3 oct 2026 a las 14:15, Nguyen Duy Nhat Anh
(<neganhat@gmail.com>) escribi=C3=B3:
>
> Hi Adriano,
>
> I noticed this patch touches the exact same lines as a bug fix I submitte=
d
> earlier for ecryptfs (the ecryptfs_get_key_payload_data fix):
> https://lore.kernel.org/all/20260917044558.41677-1-neganhat@gmail.com/T/
>
> Since your patch expands on this area, could you please add my
> Co-developed-by or Reported-by tag to this series?
>
> Thanks,
> Anh

Hi Anh,

Sure, I will send a v2
