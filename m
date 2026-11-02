Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793654904;
	b=aVmXEELJwIz7yS1nRYhro9U/brij+hNKkHeH05Ike45NwWjmZFPRYlJ1XcTMbYjGWFdD
	 +GZuO6AbKFOMACql8yHcNXfcNrb0qRPY4EQgjZlibz/4DjLm6XJS1UNh3xLJjn4nw2Lf+
	 yDxnVdgddgT/nyqSRBY9ZvtuTX4lsEN1qSPwaosrz4n3kARsr7/VcpuFTRuurkUwmo1ax
	 C7bDG8I2qZ9VQH3MRPY7KvaTY2Ve5etO2ez0l/+3OR4ifKE25Ud5C3huOkYod+N4P5gCW
	 4YozxFEt64geAbsoRjP8LUdRdW3ySvwqNlIRzEt128OqHYUqWh9WbZUR19fJ9i0vmrw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793654904;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=37I37kxjnkpufv60nnFSmrcC2M8I5JiI7AMLkywezlY=;
	b=d9SZRezz0t44Qaxa63FFbc0ReJD2GwSq/g4KDKezyOr/4oEDy/LZOLnhrcOD3qdCeqxh
	 3xr9UYRPa0c1w1CLvimqO7jWY0wu1Vaf1QDDVRnQ8FxZ9HnCWARSjfxRGQ3xgmkXZsmHC
	 uOMTwaEi3uluIpIetmqDBiZuMsD52itBxFY7O4E/5jNMEp8/TPQQyHWEmt5w/H7Tse13e
	 /ZuY6cp3Zpj+/VSy8YoNwcfb8rLTacUtLfGYEFtfW3UuD1s2Or3/ITI/MD+cXteQ8UBGY
	 7K7oJXaWj/mD7cCkt3u4STuI0AlB8kodWUmw5fLrgptJ2WFC4rMNMIQsN707p25Zx8A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=YGUDwrm4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50E9606A324
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 21:28:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A50E9606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=YGUDwrm4
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c49c32650adso449512166b.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 13:28:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793654902; cv=none;
        d=google.com; s=arc-20260327;
        b=KCAVTeAEggp2i6LMdVbH7MJW6VGM3+AyMU2lyzBJLdW/BXhLFqreWy/2NDRkMLEoC/
         RjqtKTQtWAboSJG9FYYAQVLMrqhZnELTACezn9z+G6MBeVDlB6qY2cjdVzd3/B9Zf2GH
         shqpF+XUN6FLfUTAVKQ30T6oYcH92BKDeySwjJeZyuILF+lm/HFpmLQCgiqQVEI1rkpP
         FvgxUyHnxdJRarn73XoeYZVYXg/P7xqwXzYUkd28zKwg6f29VZLsjT+WHOYbAfpKlame
         h9kEVY/bVuhFAWPpJ/XkXg/eUbWEx9pgjDx630Ftpl7m3KDRLKIhJOOhMtVsQvvr/HBJ
         ZCaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=37I37kxjnkpufv60nnFSmrcC2M8I5JiI7AMLkywezlY=;
        fh=H9ozklKtaZWfT+oxILafJU7y4LJsJF/hWB4243Gi0Jc=;
        b=BYoCcvYv+j+3yBgcwCqL/zZbb35rd7uusIXKn6PUdy4nAqki1yXelocTpn21tOlNNL
         0mASyCfXfuKqBA2yxekULU3b8vtiirzGyCNlfwwSlCY+4GOIaHKMulfbFiiyc4K3f96r
         dwBAX38Zot4PlFrg4MCKkCI4mInNZeZC7OUCdb5ZpjD2GpX7ctI86R0vnCQ7sPXQu3kG
         ZiuPTyIf9qh5BVpQbH672T6YrWRuaytq3SLhpqRiW6dMdbtIcuWFNYnjBCzMjjxtKF/D
         4sguvIEjPmGRuLqXXgXnQFZmIqNexKWliOGmcUqI5RFaAOk2mHmoIHVo3Um4DsdZXs2E
         6PhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1793654902; x=1794259702; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=37I37kxjnkpufv60nnFSmrcC2M8I5JiI7AMLkywezlY=;
        b=YGUDwrm4caqQiyVq1i9Nlg7kypsuHhbEdhFqMYOUXfQ4x4ZCwo+SK1/z2fXrUSo4v6
         iIeLT6Tdc1RQlZWPp3vjNV3k7EPIqX2I5e6U7zE9RtNU9XaNw/SOb2DwNtGXNeYZ8a3W
         JTtzEldhuLQ4GjgXnRM3VuxEhfU3BodEo6iiLA5ImTPflK0PyO6zvI/wBjlasONFZ2YM
         JyFHbbMNWO0sG8Re7Jvy6tuJMdhQ+Zp4EVh6L16IAPlda2f8OBZCqbZizkfFBuQi9rLP
         VmIK5OT0/sxP80xZ+bmbBhXYsos01PTS55mJaPdOl+QxZegxioZVbEq65g9svGPs3k/w
         WPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793654902; x=1794259702;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=37I37kxjnkpufv60nnFSmrcC2M8I5JiI7AMLkywezlY=;
        b=y8WHomigPMAHn2l5y0FUB4OqPwyDV2E6xaiKVhMQObRXa49pSDTpiTAJ14BmO9qjnw
         vCf4gr9mQZ0RGr0khl6MYw45Hw9Qw6ar0UT8SHqu4QyqYlSurG1IMPv9/7h4sRLDJlv6
         GHjqd0FsgBHZCWovzMzi5ctGDh/5XhXp8aju1Sm6qDD3prUgO+fhNYBIKs7utx6/LgYz
         NzSKFk4S3tomHyHAB0M3Go9x3QfRuTaXOoEoiG3K+el7pTL8p1Jl7rqp8mha3v4ftq+d
         uwFbinu/3hWTHDI1nManPw4tUw4jXn5d65e7vLJMiy18Lfey4Fclc6d0pOvkIogJqL8r
         cTwQ==
X-Forwarded-Encrypted: i=1; AKwUvBxxXSKhx8KybL2Em/yMOVs4GreZe2LTaP1kQHUJy/39aIyqobKQ8nex0qYNwWTQlIwsxOsb0HQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ZB9zupTm6kTXBAe/E1aCkZL5lxqHNzX9LeM6UgZoIAySj//7C
	rT6tp546DjvOsuT+S1eAjbnkTU5FhNeHAmi3tprXa45hxNo/4G8b7RIYq5+L66qQ58uOALfioBJ
	HFudOqbqUcoj0FN2e+AsqaW+GuekfLYwK2I3ejfu2tQ==
X-Gm-Gg: AYBFou2SWwb4g7oq3nLDuRYzaMYSKHDHL3A3yq9ze29z/fJEF3TISg1xRzjNn6SEdiG
	CmQ3x16ktfiI5hXLnju9+87KDs3W5Jh/+n3elBRKmOroyfGHv+Bu9wF87yCYuRMdHhSj0gtY0Ip
	k7ML/Sie++X6FfFapUoZCjyaUVI5QprahdXjJ2NP/m16pMo1O7Yt7AWSu4u/LHHufA3yl3y4KDy
	LG8R5MQ0D9WOsCkP1F5FXFIOrjHkTjIlzEEBSg8hvWal/zqb6fiXgwJY6URP2t6EPY306ayul5L
	QVud6PQvbc/SK3FSCGF35pFWZUzJ6xH0zI2tXWAk8zLy28Ef1D398CiEWEbzV+HvaK90R7NYddj
	eMZ9UUIly1mVwmFW6XKOIZKS7N8zcRNnUOqm1vEEE0KPYduFKUR6o8/n/rCNSPyHr0Ein2r8Vec
	8FqBJC2jrhwAE=
X-Received: by 2002:a17:906:99c9:b0:c2d:c247:5400 with SMTP id
 a640c23a62f3a-c4ca7b405c5mr892947966b.27.1793654902069; Mon, 02 Nov 2026
 13:28:22 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260902124026.1774575-1-max.kellermann@ionos.com>
 <CAOJNxRJ9rUZ4JRwcqEtOPu97D3NNsjwV1mniM6LdNytRYiA54w@mail.gmail.com> <CAOi1vP-yKSeBwA=269uACaXmmfX+Bpjwk_x_uJNOtRtohH=ybQ@mail.gmail.com>
In-Reply-To: <CAOi1vP-yKSeBwA=269uACaXmmfX+Bpjwk_x_uJNOtRtohH=ybQ@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 2 Nov 2026 22:28:09 +0100
X-Gm-Features: AclHuK8Fp7ROZ027fzJ_D30OkjRV4Gj_9sSayx7R-Ne65Fcxlkky1UZTTEAAqpQ
Message-ID: <CAKPOu+9=4MUMvZt80T+Kxt_+B3MEpWUTZRnW=LJShBJyNTw79Q@mail.gmail.com>
Subject: Re: [PATCH] ceph: acquire caps for read_folio requests without an rw context
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Xiubo Li <xiubo.li@clyso.com>, amarkuze@redhat.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 10:01=E2=80=AFPM Ilya Dryomov <idryomov@gmail.com> w=
rote:
> Did you get a chance to follow up on Xiubo's comments?  Particularly on
> whether the data corruption aspect is indeed gone with EROFS switching
> away from read_mapping_folio() in the upcoming release:

No, I didn't take the time to verify Xiubo's reply, and since this
data corruption bug never occurred again with my fix (and I had
stopped submitting Ceph kclient patches), I had no urgent reason to
revisit it.

--=20
Max Kellermann
Principal Architect
Hosting Technology

cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
General information about the company can be found here:
https://www.cm4all.com/impressum
A member of the IONOS Group
