Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C213E43A80A
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 15:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788278088; cv=none; b=cwjt+dzXcRsTJw5QxTTcLZH608YgCxwDAYgrlNUelRknYpHzh1ggrmOl3f9SOu5VQufyrgMRdgJ1/Q3Yn4Pj0aKxiRQNvfc/6M26njDhdUwINfX1qRKCdRQJYzuTvrtwjzG5o1kB922bWs5RPnA3C/LwPebY5RqufiyZzyHBvQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788278088; c=relaxed/simple;
	bh=fChNNIeTRqBn5nqD90K0ukY1OdPy6INqd7R3VWIz5Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QcEFXYec4kd8iU1qb895sx6iiUkxklO5wprC6yFpCDhVSxcvOlPrnk5AkpII+ERtc56sEFRr9al7GZma2N89jH/TXLcx2+xp5bdajva/O+K7H6kbi7J1Q7CjlN1sxGLzc2Z6Cocu4T/X+CWM39syvXgngb0zYpfxH85HUhMdM04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=LprvfNhS; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="LprvfNhS"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-90cd4631090so14888296d6.1
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 08:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1788278085; x=1788882885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ucz+U5vH56qFJK/L4c9McNdRpbMBTFsKxX9xAzx9wCw=;
        b=LprvfNhS/aYyHT5i8pP7jZwsbo6MnY0T2SCk9DlESe0FzpHncRGruaAtrK+WHPRorZ
         jeLQkRo/PB5WcCS093WIQ8VHsvg6pc44Xbvv7/ylZ6bN8cGpPQP0dGUVUqkkONiRMqH9
         qg0vNkKwBUPOvpLqP0UAwdfVbL4o+dG6uGbu9A4Rzzk1zSSrFREMWPU37KYr+fbpedTp
         Oc+rhJwsQvrviyedAITwZFTehNgkGODNhcco/+i1coVNRwTHDMhbX6YNHcwq/0GRaJ5r
         d0INUgDoJaQxvBOL3T5uO851JxCeKnA42FT6ZmKii0Kw5ZTtvlZA1N1o3EQOE/BPne54
         GOQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788278085; x=1788882885;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ucz+U5vH56qFJK/L4c9McNdRpbMBTFsKxX9xAzx9wCw=;
        b=NAP1BN5hhqin6dpVo/SDcvNiY5+KkTiPTartRSq3OuWCSHPkoPU/nu6q4UDJFJhtJe
         u77Fuek3dp87230WAJ+cU5lE3bjAscoV8zFzLPSPJfsKnMsFdZe7VI0sDl4XzPn09cMK
         EsAzyA1g8sAk/6EbDrVQXTL14kas2RwLxXAJ9IBqmQ5NYuDGoPVzh35UTWQ03dzHANOh
         by34RPehlzNJc4t2O6VUJoqr776dZhm0G36Mg7LJtwmCgemfFdH03BzExa/maUexkPU0
         JDdk8oHWAdYj3EQT/N3EXNhJYAAGmuccN9m24+nYro+5T51aGKwB/WtSMkCW2HrdsTW+
         JIYQ==
X-Forwarded-Encrypted: i=1; AKwUvBywKf1s62u07C7HFbXc6U3FaP1zbrjVbuoXswMiNCcwSa7OlGxG50wJgxW5xyGmU9oVq3kfDjA=@vger.kernel.org
X-Gm-Message-State: AFuF++m5Bvmwe/2WjJWRWbBwwLYRkNBOLeQ6NOIiJ5oaD7/0SF+mWgJ8
	uKw1defSwMG1/fap8FR8kPwEBAksZq/hH24EPG3j4KvwUQCv69k6W5XLTOdhXmsAt9A=
X-Gm-Gg: AYBFou38kBz2vMPgYvWl7OrnYR6A3kfvUxJTsvR9szHQJ+Bf9oaYzZHU3ycD95hJjSj
	3n7DzjhoTyt01nmBI9k3bO6fKJbmnkqHXjAkKvRuIaKCWu9H3P/c2W4IKNzvui3Pdxyy6+SIC2p
	GRkcNHz7A5Bp4NMT/JFY+ofyGa2xx7sPQjfgZhkfCVcSsVFghZFnb6dv3Id2FOOt50nB5NW1LV5
	jF6gjvcQj3lKT1jrKaPbutHIWK9fZR0jxadPfoK2KUBHj9O4nzUQ2Wj9PDrhDonBOU2bH0JjzdA
	Q5Ipgb2ReZfoOz0x7lIBJcd7sgEB4O/jXcg3rZGNcfvFu8rwUihvLghaJj5tLTGA6cBJcJeYrER
	O3IcmZOCN6EReMs+9a+2p5LvbSi/IEuzPH7Xl50ZggaWdDBEiipxsLXr/zF4irzDyduOYlE4oAR
	II3DWPYRwWhOiepoV9CPDhVp7zTda11xczA1yBxQ1poKa+4xkrTgQUhtgDacHkm/44yOqs+d/OJ
	P/kJetc2eVEwY6v8Qiwj4PD+VvadyeZFJ6ThmGmA514
X-Received: by 2002:ad4:5cc7:0:b0:90c:c1eb:ae42 with SMTP id 6a1803df08f44-90e9579ed9amr72405516d6.13.1788278085601;
        Tue, 01 Sep 2026 08:54:45 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90ce4512dcasm111045856d6.34.2026.09.01.08.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 08:54:45 -0700 (PDT)
Date: Tue, 1 Sep 2026 11:54:43 -0400
From: Gregory Price <gourry@gourry.net>
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	akpm@linux-foundation.org, david@kernel.org, ziy@nvidia.com, matthew.brost@intel.com, 
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, apopple@nvidia.com, 
	urezki@gmail.com, chenwandun@huawei.com, 
	Chelsy Ratnawat <chelsyratnawat2001@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/mempolicy: take a cpuset cookie for the interleave
 node count
Message-ID: <apb1Mq0rJfNwh7Xa@gourry-fedora-PF4VCD3F>
References: <20260828193111.1023497-1-gourry@gourry.net>
 <877bl5qknu.fsf@DESKTOP-5N7EMDA>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877bl5qknu.fsf@DESKTOP-5N7EMDA>

On Tue, Sep 01, 2026 at 07:24:21PM +0800, Huang, Ying wrote:
> Gregory Price <gourry@gourry.net> writes:
> 
> LGTM, feel free to add my
> 
> Reviewed-by: Huang Ying <ying.huang@linux.alibaba.com>
> 
> in the future version.
> 

Thank you!
~Gregory
