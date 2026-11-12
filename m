Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794490257;
	b=s1cy4T1Y9ROGQ66ljawATqi9HNwUg852pl7nRcKGoK+esuZe0R2Ekgkd5Vj0DGzBb5YC
	 YIrgKZHgqzjBsGsgVQI9+2Jk0y4hQ7mnTWfkKu7sJIFHfQHmDoHOn3sljrRmI2GsRujUu
	 Bs7bQeLHFVkuvx6GmVhLDEnzPXbGulk/f7CKfii1eBKpLbEX9nCzpV+5UTJ4u3RoNcai8
	 IfMJfst6qbwofT7QbTSBS6BUQBMWmjnVxKUNRgVnu1DdRpz6ZUulordh5xsevagRXVOGj
	 gTzAPKfDCkmxMR6jD9g/T0EKJmCVdn/0PfkBlgC3253ZMVCZ+KnwW0tsS8eSTldCdBA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490257;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=S1xZYGW3sp4V9GD5hAamXepdrQgJ2mYyugoBZizhATM=;
	b=PKENK9Vqn5Flqd0SUhs+zDQ7+PQYmsOm/SCZuK0HZo/AksPtvlcmZPJguQ2LSKBm4FMx
	 75IdfL8ZpsKFb+4k3fAhRpdD8/71eANnHssyYGeIkC/JtiNvoybwXHJGw5wJDUwUM+pPf
	 0fIJATtJ4T+xk9bS0JoQSfKpUcsU/I1UqAFsycm6NStPFz7tyfE7HeMSZBLy2JVnjXUYc
	 yeGCdLF1NUQ+1a5N8g5GanoEXctkX4zkbeLtE5HV8pc5dejL5jxpMU7ZoOK7hHSfPvCrt
	 19NMoxrvglrEkSIpHA9gHspFclcSboqXda33NX1ZIgonpfsFmWd2Rt92BJ9T7MLmgeA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OAMZCKUT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5D9606A893
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 13:30:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B5D9606A893
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OAMZCKUT
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-490f38e9688so762476f8f.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 05:30:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794490256; cv=none;
        d=google.com; s=arc-20260327;
        b=KaLErc/JcFCRZBX3Bdil7F6r2J0Yk46cRg4MnvQpielMkaUFoEyYAmPnsrsBLa5h8O
         W2iqz5Wabxdx+3nzJk/3Vx2/nvew0kWTFI09bJ+gOS5XyuFWiSdTdFfZwJvw7CS0dTu7
         ZQwVMARnUhjuJTo+ljWG1d3jqkbvWQ/Frb0HcVZxp+e5aMtu67vSMKKtsxJbAF4GpNep
         wMF71AjliMt9tTzQnf0i6AUVFKQVv5nevnGzOhITwehiNaoyu2WU7oPidcjg4xqK9mhZ
         ovgusV5Pce6p5MaBeA0Q2d9kWgTf1NgT1HvKxUjTLQt1Vcpso6e3KNiAVvoMTCO10wVW
         L0UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S1xZYGW3sp4V9GD5hAamXepdrQgJ2mYyugoBZizhATM=;
        fh=xV39+LiA4WV/WS8OT+DQAcBstN3kHBhGy/sldBRqaxo=;
        b=p3kxDHhLkgc+58MNZD3bx7VUMdbs43n7Cn63bqNQCizf4pLFdycnaiJwWd0rM/7ogq
         28G0qjt/K5G5s6N1uSTSKnzHo9Prkck6v8OKf+dUEabznLu8w/GraOb6/rgQuVPLbe7L
         mnWPFMkTEyQp7inOSsWI/a5l31kzLrNt23pBmyNA2Qb3pWYJpLf9dA364+dY1NUYVkMw
         eq7qZrKYz5hlBnQkUqX2U5iB0NsRyKVHso8G798kq+bkANoMJR/InHA/LskZt6HiQBNG
         9tuJHva3ZitcKytkLaTTIBM7rUvzGexQJOCC4x0DTiKn25gY5qBJdoyvCVkBvqLUepbQ
         yDbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794490256; x=1795095056; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S1xZYGW3sp4V9GD5hAamXepdrQgJ2mYyugoBZizhATM=;
        b=OAMZCKUTw3l6QKgGiSX8VX6jr2xJ0IvEcRr9aN8o+RSKzS0Ud1802z5BmqWJ9NxpS9
         o3yLiXe7EpfLOU8AotMwhaxYDX4IYn1kaXcRWUjxRNpbsVVTbOoX65nZtlh4BRg7T78D
         MTxgNivkTdUXHnu2V/QGcXltawmwZRgBJaZ0sSaelhIj00Pme/vMlmyVyUawmp6C3OCW
         1iC+F2PRLrkgfuby5NfOjvtseFVMYZdoGPviqrzEx0yJTu2zE9Qu083p+IxoE7l30IGw
         8rESjm9DJhyoCPUVWYMRKsEyZzYzcOZZZkiu1d81jda1IdrKguAiClSkm1H9k/aPdZ6l
         hBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794490256; x=1795095056;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S1xZYGW3sp4V9GD5hAamXepdrQgJ2mYyugoBZizhATM=;
        b=mxtAvOY1joPmG0IYx+7x5COKjAwCaytnIrYhvU8tY/qvVnu/2263R4G/S557I7NVyZ
         yIasQsDzPaUMEIw0MNOohpH3R5MDchprdZlTqP6G9ftyAfa1vgKPK1Q0yM+KD2hAoi8e
         3tdqdNPLdnh8rCTOs4V8fWzv+Qleh0i8i4HSjpzJWkiID5mqK+FkEiJxtGPwOr5e0009
         16tKXnoUA9GEjS4iub2RJPVGGIbR6bJhI7r/+nZoG+t4LjZS/iCgP3nU7hFkXa5dIs4F
         aHl6jcyvRT+J1Kak+KRmcp99SKdXGfmd3zvvm4Te5W+p5OaWDkvY1F+bHz+bi96hsezo
         T2Mg==
X-Forwarded-Encrypted: i=1; AL+hErHLHvIHv9FbHd5FQYwLdgsz6+EHc7UtMC2CJo0p61+Aly+7OW+TrvvOHZ8zjSEiOSYVPacUpgs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Ya3r515LTGq+Dkp09cfWTU4aaf1BQveIvBXMKTrg9f+iz/BbP
	1K4/9xXFvjtSBsKIBqYDifNj6s8zW9weZljvg4svk7A3RbJKKHU6/UiHSEaO3Pd9k1kuEPXOjwv
	2SVO14jYlcKQYt9z4Y2Qkmirh8TCYpDo=
X-Gm-Gg: AYBFou0pE8zWihNUYv0LIsrelbj//fcIWou9Ux4JMMHjfKJc3Fntp6fLMBdXcqyT5og
	yqYHtJuRXkXrsS/oU+FTPaut9ay64ULxlPQBe++0U9rwd7LqkLFiBXeelwYD8zekfi3rdk4W1+4
	Z7MlSHUuT9OeUa3LSOjEKE5SjqAbALOfOrD27rpgui1CPF+3it2rNlzfr8oXUm0cEL8JmOwQBok
	kZFFckqgw3NUo+F41MbhwS6e1OeVhd7cvimo0nCsZFBJJcwUrU69wAWBegIBgYgdtL6adJYPxOP
	pczdX5Il3tikFn1snY6euIfTIa/2Mn6S9KbvJTMZAMqAShZ0oBH7fDupHpkcr1KU9Tj4RZuyf+V
	u+UVd9BvWZZzU5oThpczjPiyxqbo8DKDMT7X6RsvfrVajBb2WaaBtSUR9/AcVwztdtboL2tf3dG
	oWJIdCHJJtaudoMFp+VNloxlGVxbTBNYV3DaNaZ+WPeZr+J+N11hHNaK5arXwggqb8vMztX7HqW
	Q==
X-Received: by 2002:adf:e00e:0:20b0:491:632f:2c8f with SMTP id
 ffacd0b85a97d-49afe168872mr4263229f8f.2.1794490255492; Thu, 12 Nov 2026
 05:30:55 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org> <20261111-mason-migrate-et-al-fixes-v1-2-3d2454362e8d@kernel.org>
In-Reply-To: <20261111-mason-migrate-et-al-fixes-v1-2-3d2454362e8d@kernel.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 12 Nov 2026 06:30:43 -0700
X-Gm-Features: AclHuK_EMQbfmXamV3TaIqS6catb5--28CKUD5GkvfpyfyoaKenoCKPieGjScZg
Message-ID: <CAKEwX=MDNW=tj5cfSrAN=VG-NEd2cax6f7QHcPfGDc1vTix+TQ@mail.gmail.com>
Subject: Re: [PATCH 02/13] mm: cachestat: count each page only once
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Usama Arif <usama.arif@linux.dev>, Kairui Song <kasong@tencent.com>, 
	Balbir Singh <balbirs@nvidia.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Dennis Zhou <dennis@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, Peng Fan <peng.fan@nxp.com>, 
	Josef Bacik <jbacik@fb.com>, Chris Mason <mason@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Mark Brown <broonie@kernel.org>, 
	"Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 11:14=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.=
org> wrote:
>
> From: Chris Mason <mason@kernel.org>
>
> It turns out that filemap_cachestat() can unwittingly return incorrect
> page counts, if large folios are present.
>
> This can occur due to underflow - nr_cache is nearly 2^64 on a 64-bit
> kernel if the input range starts more than 64 pages into a folio that is
> split during the call.
>
> It can also occur due to pages after a large folio being skipped if the
> range starts in its second or later XArray slot and the call reschedules =
at
> that folio.
>
> Finally it can be caused by pages being counted twice due to folios in th=
e
> range being split or collapsed during the call.
>
> filemap_cachestat() walks the page cache under the RCU read lock only,
> and for each entry it counts the pages that lie in the range. It does
> not track how far it has counted, so the counts are only right if the
> walk returns each index once.
>
> But a large folio can be split during the walk, or small folios can be
> collapsed into a large one, and the next entries then cover indices that
> were already counted.
>
> Resolve the issue by tracking the current index as one past the last inde=
x
> in the folio, and explicitly using xas_set() to set the current position =
in
> the XArray.
>
> Additionally, add a check for folio_last_index reaching or exceeding
> last_index and break out of the loop if so.
>
> Fixes: cf264e1329fb ("cachestat: implement cachestat syscall")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ ljs: updated to use curr_index, fixed comments, updated commit message =
]
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Thanks, Chris and Lorenzo, for taking a look at this!

Acked-by: Nhat Pham <nphamcs@gmail.com>
