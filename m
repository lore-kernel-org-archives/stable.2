Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C5333938F
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 04:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788840639; cv=none; b=L6+py8Zvsd3wXhrfqKodyCVYKb6wwMNf6UpERPRV0kycRSIhFlf11Fi5lJz3U9/pQFjp1HQUa1p8nwS+y3XLhOQwMTGlapuTUfk62Q9dmNN9DluPJ9dOYuvtvU0RiaRWBd4cZv8fxcJWdW1AqC6bvfAc3CTi452NodJ7iiEbeic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788840639; c=relaxed/simple;
	bh=BDT5nxYXMmZn++Gzql5ffym2zj5FsDZfX6gFd7ck4pA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EnjpB3igTyU1WAIKQYh5Da5re/SZu2PKJ5cI1V5aKbGHGJNYzyt06obp+cwJRk1XVA2K2dKnzHXYMwETI3sDShDV+hIEsxHiuMg7gIgM+jiqv3B3/Wrfttv2SqqfWIaMnTk32zOLh9s4Me1xpbus7kk7fo/zEikaE8E2Rytx388=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZbEAUhU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZbEAUhU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6281F00AC4
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 04:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788840637;
	bh=nV0JKeMZMS6STLhK/ANSZRNY6AFJEmTUQYldyO5ECpc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NZbEAUhUSzOCcvo0459HnYoKMDlGkn3ndjXZFj7dXeacX0DkW8EuJIRyFgkuOQWDB
	 Ald25uGtpxF7CZmSAtKP95N9lZ+p3Ev9CVQcEoPCrkWHKbwz1c3ChjxLSge2hlHVht
	 heFuSjaVXLzgUzsbry1Zhv9ZOcJpjRAQHdT1DUt+VR5cPTLq2apcNEuWZxQqOcPl0B
	 GY3dYwUHA2EIn5VRpMnwAHLaP8JG0rT23Ki6pMjrTTVyq/dfJZOV/Pqx597j7icXRZ
	 U6eb+kzGVWfhxVM1Pw1fGLrL8TEVc7alHyajYORaQr0wqKsfMj98IIvTnRRokAf7dr
	 9lOrWlTLb3Leg==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c2055573c8cso521885566b.3
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 21:10:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwrGkUj6vahzkFCYvyUhv6LbEaxoWJdMRtQYlA6Y7JA+G79KxjJPZJN1LgddcOx8m2YqcD9J9M=@vger.kernel.org
X-Gm-Message-State: AFuF++k2SXnMqv7HHXzLXizx7NsJJ2zE+iQrdn2dI9McfTqUgKBzxhey
	6y5Z0t1cT/QHbGQRbp+RsU04eoi6ZzT1NqCeT00ElynOCYH6qW5aIktN1lmkGqqJOlOGkcqynZC
	490PGgquEZTwDl0t96QqgZwwlOPdKxGs=
X-Received: by 2002:a17:906:6a1d:b0:c26:1649:47b5 with SMTP id
 a640c23a62f3a-c2616495671mr949630566b.43.1788840635644; Mon, 07 Sep 2026
 21:10:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907070852.291323-1-zenghongling@kylinos.cn> <20260907070852.291323-3-zenghongling@kylinos.cn>
In-Reply-To: <20260907070852.291323-3-zenghongling@kylinos.cn>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 8 Sep 2026 13:10:23 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9Hs1aEe_Tx4QwaKVUWM9RSrkAcO9Q7naMQWxg_2G0vAg@mail.gmail.com>
X-Gm-Features: AcwNN1VNTCtn8WAo4XDE0Z3ah-hgIbS3QYG2qzLu1C4ItDdYGmQPmTpEjM8yrWo
Message-ID: <CAKYAXd9Hs1aEe_Tx4QwaKVUWM9RSrkAcO9Q7naMQWxg_2G0vAg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] ntfs: sync the volume dirty bit with the recorded
 error state
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: hyc.lee@gmail.com, ntfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	zhongling0719@126.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> @@ -1621,6 +1666,11 @@ static bool load_system_files(struct ntfs_volume *vol)
>                         ntfs_error(sb, "%s.  Mounting read-only%s", es1, es2);
>                 }
>                 NVolSetErrors(vol);
> +               /*
> +                * Remember it for the lifetime of the mount: see
> +                * ntfs_sync_volume_dirty_state().
> +                */
> +               NVolSetHibernated(vol);
Could you explain why NVolSetHibernated(vol) is called for non-zero
return from check_windows_hibernation_status() ?
