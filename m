Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335C23B19A0
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 14:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790865283; cv=none; b=aqvcl5ajKpnBtQd3Nod8g6e2b1LXK1WXHQW0BlAxAx9oDmKl3bqUuORnS2ULdmO8/j45DmxyPG6Xg1tTPgZ2QOhwx/AZ8fKEV7IDMsFMtdoivFCQhtArZivQhFFwsZk5TKiKgKk+xNgINUUqSpHTVBCOGv/POZpZTkYh3CLUdUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790865283; c=relaxed/simple;
	bh=EqMbMECS/t3vccpilsRChSaq7nHSoFEt06+pq6s7Wug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XfKobiEMXl3caev8B4e61LLSUUOCbhaP1MSOoOt21dOTExmgEKuO9qA74G9cpGLKMvqmHsJbazhy6tMxij1lU/Nk7Oezv5Z0EgMjrOtZbZOgC88JoKRjP/0jj8mQVQYF9Ob924jcGqgp89c421NBd2XxZTzVOQZbsVaklHB+zNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNj6BWYR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNj6BWYR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A931F000FF
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 14:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790865278;
	bh=fPM/4SeHch6pzXrCpR9Y27L1SZ7b9gGTaXj74w9Jua8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=aNj6BWYR3olZkAJJnj8BRriVmf9zOM1axIBqSY61jnXKoGzR3LcfendxV7QQ6SuOx
	 w86a68MYHh8ZA1skTW9K+qe1wzrftdm7QQaMrl4p2nRMf0b87ON61KMIikwfjgMxZT
	 yBmTEcClpC3W5ekda335eE3f/0wPUStID6ciGg03qYyhs6Lc16QsB//cLYxak4DjR6
	 hhb+55hMOJFR/1JRMaT46sUpOh4ygENcsopUXWJhbs2DmFpEyA5WSzGVWDM0ThrdcF
	 LWnsmxdXceoKD9mauwPVeAEPYsF6pK/VCY9N2s5KlCiuwb0qHhIWsDAKNY4tD2INb5
	 4QHN/HLpgEP3A==
Received: by mail-qk2-f40.google.com with SMTP id af79cd13be357-93c5d67aa05so645364785a.0
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 07:34:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwMga16J6bvPipp183T/kqJxixXPE6LBpws4JZqhKY9FTxUpAK1z2FzlVh52ZKJ+wfWnXKes8g=@vger.kernel.org
X-Gm-Message-State: AFuF++lUlNK2pN5y2QIfLRr5oc4StByTTx6xk1AdXPclTSnlbmsFJYhZ
	Aus7dfS952g3GZVt4QtZx7VZzaO821aLtRhZE4X5eTtHn7Xp4grMxdonFDzeCbt+ZTYO9xlfHs+
	ezV+77wFt+JfoQt4v7Z11qedZTFcdgAk=
X-Received: by 2002:a05:620a:2550:b0:93c:3d7e:6e90 with SMTP id
 af79cd13be357-93ca96e9ddemr860429585a.32.1790865278068; Thu, 01 Oct 2026
 07:34:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730030031.28678-1-ali@iusegentoo.com>
In-Reply-To: <20260730030031.28678-1-ali@iusegentoo.com>
From: Len Brown <lenb@kernel.org>
Date: Thu, 1 Oct 2026 10:34:25 -0400
X-Gmail-Original-Message-ID: <CAJvTdKn_OrEQNBH=uW6exhW8Y3GoqGGujBNxU36GTqwQy92myg@mail.gmail.com>
X-Gm-Features: AclHuK_OaFtvuk_AMu9BzLHuUYBE8rlL8qthlcNrdVlLY-j_DpowU_julj-x06Y
Message-ID: <CAJvTdKn_OrEQNBH=uW6exhW8Y3GoqGGujBNxU36GTqwQy92myg@mail.gmail.com>
Subject: Re: [PATCH] tools/power turbostat: Read complete CPU lists
To: Ali Ahmet Memis <ali@iusegentoo.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied -- thanks!

-Len Brown
Intel Open Source Technology Center

On Wed, Jul 29, 2026 at 11:00=E2=80=AFPM Ali Ahmet Memis <ali@iusegentoo.co=
m> wrote:
>
> CPU_SUBSET_MAXCPUS accepts CPU IDs through 8191, but the sysfs and
> cgroup CPU-list readers stop at 1024 bytes. A fragmented cpuset or
> hybrid PMU CPU list can exceed that size and be truncated.
> initialize_cpu_set_from_sysfs() can also pass a full, non-NUL-terminated
> buffer to parse_cpu_str(), causing an out-of-bounds read.
>
> Additionally, initialize_cpu_set_from_sysfs() returns with the file
> still open on success. It is now called once per CPU for
> thread_siblings_list, so large systems can leak thousands of descriptors
> during topology discovery.
>
> Use getline() so both readers receive a complete, NUL-terminated line.
> Close and free the sysfs CPU-list resources on every path, and report
> malformed input from the correct buffer.
>
> Fixes: eb187540d13a ("tools/power turbostat: Increase CPU_SUBSET_MAXCPUS =
to 8192")
> Fixes: 58839fdbd441 ("tools/power turbostat: Process HT siblings in CPU o=
rder")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>
> ---
>  tools/power/x86/turbostat/turbostat.c | 44 +++++++++++++++------------
>  1 file changed, 25 insertions(+), 19 deletions(-)
>
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turb=
ostat/turbostat.c
> index 920694c3c..cec3f2fbb 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -6311,33 +6311,35 @@ int for_all_proc_cpus(int (func) (int))
>
>  #define PATH_EFFECTIVE_CPUS    "/sys/fs/cgroup/cpuset.cpus.effective"
>
> -static char cpu_effective_str[1024];
> +static char *cpu_effective_str;
>
>  static int update_effective_str(bool startup)
>  {
>         FILE *fp;
> -       char *pos;
> -       char buf[1024];
> +       char *buf =3D NULL;
> +       size_t size =3D 0;
>         int ret;
>
> -       if (cpu_effective_str[0] =3D=3D '\0' && !startup)
> +       if (!cpu_effective_str && !startup)
>                 return 0;
>
>         fp =3D fopen(PATH_EFFECTIVE_CPUS, "r");
>         if (!fp)
>                 return 0;
>
> -       pos =3D fgets(buf, 1024, fp);
> -       if (!pos)
> +       if (getline(&buf, &size, fp) < 0)
>                 err(1, "%s: file read failed", PATH_EFFECTIVE_CPUS);
>
>         fclose(fp);
>
> -       ret =3D strncmp(cpu_effective_str, buf, 1024);
> -       if (!ret)
> +       ret =3D cpu_effective_str ? strcmp(cpu_effective_str, buf) : 1;
> +       if (!ret) {
> +               free(buf);
>                 return 0;
> +       }
>
> -       strncpy(cpu_effective_str, buf, 1024);
> +       free(cpu_effective_str);
> +       cpu_effective_str =3D buf;
>         return 1;
>  }
>
> @@ -8529,13 +8531,16 @@ int add_rapl_perf_counter(int cpu, struct rapl_co=
unter_info_t *rci, const struct
>         return ret;
>  }
>
> -char cpuset_buf[1024];
> -int initialize_cpu_set_from_sysfs(cpu_set_t *cpu_set, char *sysfs_path, =
char *sysfs_file)
> +int initialize_cpu_set_from_sysfs(cpu_set_t *cpu_set, const char *sysfs_=
path,
> +                                 const char *sysfs_file)
>  {
>         FILE *fp;
> +       char *cpuset_buf =3D NULL;
> +       size_t size =3D 0;
>         char path[128];
> +       int ret =3D -1;
>
> -       if (snprintf(path, 128, "%s/%s", sysfs_path, sysfs_file) > 128)
> +       if (snprintf(path, sizeof(path), "%s/%s", sysfs_path, sysfs_file)=
 >=3D (int)sizeof(path))
>                 err(-1, "%s %s", sysfs_path, sysfs_file);
>
>         fp =3D fopen(path, "r");
> @@ -8543,19 +8548,20 @@ int initialize_cpu_set_from_sysfs(cpu_set_t *cpu_=
set, char *sysfs_path, char *sy
>                 warn("open %s", path);
>                 return -1;
>         }
> -       if (fread(cpuset_buf, sizeof(char), 1024, fp) =3D=3D 0) {
> +       if (getline(&cpuset_buf, &size, fp) < 0) {
>                 warn("read %s", sysfs_path);
> -               goto err;
> +               goto out;
>         }
>         if (parse_cpu_str(cpuset_buf, cpu_set, cpu_possible_setsize)) {
> -               warnx("%s: cpu str malformat %s\n", sysfs_path, cpu_effec=
tive_str);
> -               goto err;
> +               warnx("%s: cpu str malformat %s\n", sysfs_path, cpuset_bu=
f);
> +               goto out;
>         }
> -       return 0;
> +       ret =3D 0;
>
> -err:
> +out:
>         fclose(fp);
> -       return -1;
> +       free(cpuset_buf);
> +       return ret;
>  }
>
>  void print_cpu_set(char *s, cpu_set_t *set)
> --
> 2.54.0
>


--=20
Len Brown, Intel Open Source Technology Center
